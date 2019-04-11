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
    @IBAction func tappedTraductionButton(_ sender: UIButton) {
        translate()
    }
    // translate text if text is fr else it's en
    func translate() {
        if frenchText.isFirstResponder {
            TraductionService.shared.PostTraduction(textToTranslate: frenchText.text!, target: "en", source: "fr") { (succes, translation) in
                if succes, let translation = translation {
                    self.englishText.text = translation.data.translations[0].translatedText
                } else {
                    self.presentAlert()
                }
            }
        } else {
            TraductionService.shared.PostTraduction(textToTranslate: englishText.text!, target: "fr", source: "en") { (succes, translation) in
                if succes, let translation = translation {
                    self.frenchText.text = translation.data.translations[0].translatedText
                } else {
                    self.presentAlert()
                }
            }
        }
    }
    // move view up if editing dollar text field
    @objc func keyboardWillChange(notification: Notification) {
        if englishText.isFirstResponder {
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
        frenchText.resignFirstResponder()
        englishText.resignFirstResponder()
    }
    // present alert
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Traduction Failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
