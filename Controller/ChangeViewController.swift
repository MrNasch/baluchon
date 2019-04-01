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
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
        dollarTextField.resignFirstResponder()
    }
    private func update(change: Change) {
        if Double(euroTextField.text!) == nil {
            euroTextField.text = "1.0"
        }
        
        let euro = Double(euroTextField.text!)!
        let usd = Double(euro * change.rates["USD"]! * 100) / 100
        dollarTextField.text = String(usd)
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
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Convert Failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
