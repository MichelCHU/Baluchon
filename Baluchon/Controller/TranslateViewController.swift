//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Square on 26/10/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:- IBOULET
    
    @IBOutlet weak var frenchLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var frenchTextField: UITextField!
    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    // MARK:- IBACTION
    @IBAction func reversalArrowButtonTapped(_ sender: Any) {
        
        if reversalArrowButton {
            reversalArrowButton = false
            frenchLabel.text = "Français"
            englishLabel.text = "Anglais"
            target = "EN"
            source = "FR"
            frenchTextField.placeholder = "Écrivez votre texte ici"
        } else {
            reversalArrowButton = true
            frenchLabel.text = "Anglais"
            englishLabel.text = "Français"
            target = "FR"
            source = "EN"
            frenchTextField.placeholder = "Write your text here"
        }
        if frenchTextField.text?.isEmpty == false {
          let text3 = text1
          text1 = text2
          text2 = text3
          frenchTextField.text = text1
          englishTextField.text = text2
        }
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextField.resignFirstResponder()
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        makeAPICall()
    }
    
    //MARK:- Property
    let service = TranslatorService()
    var reversalArrowButton: Bool = false
    var target: String = "EN"
    var source: String = "FR"
    var text1 = ""
    var text2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK:- METHODS
    
    func makeAPICall() {
        activityIndicator(activityIndicator: activityIndicator, button: translateButton, showActivityIndicator: true)
        service.getData(text: frenchTextField.text ?? "", target: target) { [self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let translate):
                    activityIndicator(activityIndicator: activityIndicator, button: translateButton, showActivityIndicator: true)
                    self.updateTranslatorDisplay(response: translate)
                case .failure:
                    alertVC(title: "No Text", message: "The service is momentarily unavaible")
                }
                activityIndicator(activityIndicator: activityIndicator, button: translateButton, showActivityIndicator: false)
            }
        }
    }
    
    func updateTranslatorDisplay(response: Translate) {
        if frenchTextField.text?.isEmpty == false {
            if frenchTextField.text != "" {
                text1 = frenchTextField.text ?? ""
                text2 = response.translations[0].text
                self.englishTextField.text = response.translations[0].text
            } else {
                englishTextField.text = ""
            }
        } else {
            alertVC(title: "No Text", message: "Enter something to translate")
        }
    }
}
