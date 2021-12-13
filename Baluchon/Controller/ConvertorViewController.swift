//
//  ConvertorViewController.swift
//  Baluchon
//
//  Created by Square on 26/10/2021.
//

import UIKit

class ConvertorViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Properties
    var service = ConvertorRatesService()
    private let convertorRatesServices: ConvertorRatesService = .init()
    
    // MARK: - IBoulets
    
    @IBOutlet weak var firstCurrencyTextField: UITextField!
    @IBOutlet weak var secondCurrencyTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!

    @IBAction func converterButton(_ sender: Any) {
        
        if let textToConvert = firstCurrencyTextField.text, textToConvert.isEmpty == false, textToConvert.isDouble == true {
            convertorRatesServices.getData { [weak self] result in // retain cycle
                DispatchQueue.main.async {
                    switch result {
                    case .success(let rates):
                        guard let rate = rates.rates["USD"] else { return }
                        guard let amount = Double(textToConvert) else { return }
                        let result = amount * rate
                        self?.secondCurrencyTextField.text = String(result)
                    case .failure:
                        self?.alertVC(title: "ERROR", message: "The service is momentarily unavaible")
                    }
                }
            }
        } else {
            alertVC(title: "ERROR", message: "Enter a number to converte")
        }
    }
        
    @IBAction func dismissKeyboard(_ sender: UIGestureRecognizer) {
        hideKeyboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func hideKeyboard () {
        firstCurrencyTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print ("Return pressed")
        firstCurrencyTextField.resignFirstResponder()
        hideKeyboard()
        return true
    }
}

extension StringProtocol {
    var isDouble: Bool { return Double(self) != nil }
}
