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
    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        showRate()
    }
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
    func showRate() {
        ChangeService.shared.getChange { (succes, Change) in
            if succes, let Change = Change {
                self.update(change: Change)
            } else {
                self.presentAlert()
            }
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
        dollarTextField.resignFirstResponder()
    }
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Convert Failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
