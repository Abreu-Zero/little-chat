//
//  LoginViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 01/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //TODO: create func to check if email and password are empty for testability
    
    
    @IBAction func login(_ sender: Any) {
        activityIndicator.startAnimating()
        
        guard let username = emailTextField.text else{
            showAlert(title: "Error", text: "username error")
            return
        }
        
        guard let password = passwordTextField.text else{
            showAlert(title: "Error", text: "password error")
            return
        }
        FirebaseHelper.loginUser(username: username, password: password) { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.activityIndicator.stopAnimating()
            }else{
               self.showAlert(title: "Error", text: error!.localizedDescription)
            }
        }
    }
    
    func showAlert(title: String, text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
               
               let action = UIAlertAction(title: "OK", style: .default)
               alert.addAction(action)
               
               self.present(alert, animated: true, completion: nil)
    }
    

}

