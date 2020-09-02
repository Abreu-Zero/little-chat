//
//  SigninViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 02/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class SigninViewController: UIViewController {

    
    //MARK: Text Fields
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" || confirmationTextField.text == "" {
            showAlert(error: 0)
        }
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        guard let confirmation = confirmationTextField.text else{return}
        
        
    }
    
    func verifyPasswordLenght(password: String) -> Bool{
        return password.count >= 8 && password.count <= 20
    }
    
    func verifyPasswordMatches(password: String, confirmation: String) ->Bool{
        return password == confirmation
    }
    
    func verifyValidPassord(password: String) -> Bool{
        let validPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{8,}$")
        return validPassword.evaluate(with: password)
    }
    
    func showAlert(error: Int){
        var title = ""
        var text = ""
        switch error{
        case 0:
            title = "Empty username or password"
            text = "Please fill the form to create an account"
        default:
            return
        }
        
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }


}
