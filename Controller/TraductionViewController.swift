//
//  TraductionViewController.swift
//  Baluchon
//
//  Created by Nasch on 21/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class TraductionViewController: UIViewController {

    
   
    @IBOutlet weak var frenchText: UITextView!
    @IBOutlet weak var englishText: UITextView!
    
    
    
    @IBAction func tappedTraductionButton(_ sender: UIButton) {
        translate()
    }
    func translate() {
        TraductionService.shared.PostTraduction(textToTranslate: frenchText.text!) { (succes, traduction) in
            if succes, let traduction = traduction {
                self.englishText.text = traduction.data.translatedText
            } else {
                self.presentAlert()
            }
        }
    }
    
    // dismiss keyboard when clic away
    @IBAction func DismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchText.resignFirstResponder()
    }
    // present alert
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Traduction Failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
