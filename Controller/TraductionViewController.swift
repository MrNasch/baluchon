//
//  TraductionViewController.swift
//  Baluchon
//
//  Created by Nasch on 21/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class TraductionViewController: UIViewController {

    
    @IBOutlet weak var frenchTextField: UITextField! //textview
    @IBOutlet weak var englishTextField: UITextField!
    @IBAction func tappedTraductionButton(_ sender: UIButton) {
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextField.resignFirstResponder()
        englishTextField.resignFirstResponder()
    }
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Traduction Failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
