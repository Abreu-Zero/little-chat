//
//  CreateAccountViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 02/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    //MARK: IBO
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: polish this shit
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        if emailTextField.text == "" || passwordTextField.text == "" || confirmationTextField.text == "" {
            showAlert(code: 0, error: nil)
        }
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        guard let confirmation = confirmationTextField.text else{return}
        guard let nickname = nicknameTextField.text else{return}
        
        if verifyPasswordLenght(password: password) && verifyValidPassord(password: password) && verifyPasswordMatches(password: password, confirmation: confirmation) && verifyNicknameLenght(nickname: nickname){
            createUser(password: password, email: email)
        } else if !verifyPasswordLenght(password: password){
            showAlert(code: 2, error: nil)
        } else if !verifyValidPassord(password: password){
            showAlert(code: 3, error: nil)
        } else if !verifyPasswordMatches(password: password, confirmation: confirmation){
            showAlert(code: 4, error: nil)
        } else if !verifyNicknameLenght(nickname: nickname){
            showAlert(code: 6, error: nil)
        }
        
        print(email)
        activityIndicator.stopAnimating()
    }
    
    func verifyPasswordLenght(password: String) -> Bool{
        return password.count >= 8 && password.count <= 20
    }
    
    func verifyPasswordMatches(password: String, confirmation: String) ->Bool{
        return password == confirmation
    }
    
    func verifyValidPassord(password: String) -> Bool{
        let validPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{8,20}$")
        return validPassword.evaluate(with: password)
    }
    
    func verifyNicknameLenght(nickname: String) -> Bool{
        return nickname.count >= 0 && nickname.count <= 20
    }
    
    func createUser(password: String, email: String){
        
        if let error = FirebaseHelper.createUser(username: email, password: password){
            self.showAlert(code: 5, error: error)
        }else{
            self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
        }
    }
    
    func showAlert(code: Int, error: Error?){
        var title = "Error"
        var text = "Something went wrong"
        switch code{
        case 0:
            text = "Please fill the form to create an account"
        case 1:
            title = "SUCCESS"
            text = "Account Created!"
        case 2:
            text = "Password must contain 8 - 20 characters"
        case 3:
            text = "Password must contain at least one upper/lower case and one special character"
        case 4:
            title = "Passwords don't match"
            text = "Please try again"
        case 5:
            text = error!.localizedDescription
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
