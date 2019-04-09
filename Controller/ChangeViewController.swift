//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Nasch on 21/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // listen to keyboards events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // Stop listening eyboard events
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        showRate()
    }
    // update view
    private func update(change: Change) {
        if euroTextField.isEditing {
            if Double(euroTextField.text!) == nil {
                euroTextField.text = "1.0"
            }
            
            let euro = Double(euroTextField.text!)!
            let usd = euro * change.rates["USD"]!
            dollarTextField.text = String(usd)
        } else {
            if Double(dollarTextField.text!) == nil {
                dollarTextField.text = "1.0"
            }
            
            let usd = Double(dollarTextField.text!)!
            let euro = usd / change.rates["USD"]!
            euroTextField.text = String(euro)
        }
    }
    // get rate from model
    func showRate() {
        ChangeService.shared.getChange { (succes, Change) in
            if succes, let Change = Change {
                self.update(change: Change)
            } else {
                self.presentAlert()
            }
        }
    }
    // move view up if editing dollar text field
    @objc func keyboardWillChange(notification: Notification) {
        if dollarTextField.isEditing {
            guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            if notification.name == UIResponder.keyboardWillShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                
                view.frame.origin.y = -keyboardRect.height
            } else {
                view.frame.origin.y = 0
            }
        }
    }
    // dismiss keyboard when clic away
    @IBAction func DismissKeyboard(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
        dollarTextField.resignFirstResponder()
    }// present alert
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Convert Failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
