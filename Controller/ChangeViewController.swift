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
