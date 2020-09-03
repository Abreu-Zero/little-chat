//
//  LoginViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 01/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //TODO: full functionality to check and login
    
    @IBAction func login(_ sender: Any) {
        activityIndicator.startAnimating()
        
        guard let username = emailTextField.text else{
            showAlert()
            return
        }
        
        guard let password = passwordTextField.text else{
            showAlert()
            return
        }
        
        Auth.auth().signIn(withEmail: <#T##String#>, link: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
        print(username + " " + password)
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "error", message: "placeholder", preferredStyle: UIAlertController.Style.alert)
               
               let action = UIAlertAction(title: "OK", style: .default)
               alert.addAction(action)
               
               self.present(alert, animated: true, completion: nil)
    }
    

}

