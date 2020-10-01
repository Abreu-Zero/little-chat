//
//  LoginViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 01/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTheme()
    }
    
    @IBAction func login(_ sender: Any) {
        activityIndicator.startAnimating()
        
        guard let username = emailTextField.text else{
            showAlert(title: "Error", text: "username error")
            self.activityIndicator.stopAnimating()
            return
        }
        
        guard let password = passwordTextField.text else{
            showAlert(title: "Error", text: "password error")
            self.activityIndicator.stopAnimating()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func showAlert(title: String, text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
               
               let action = UIAlertAction(title: "OK", style: .default)
               alert.addAction(action)
               self.present(alert, animated: true, completion: nil)

        
    }
    
    func loadTheme(){
        Themes.setThemeForView(view: bgView, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.SetThemeForLabel(label: passLabel, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.SetThemeForLabel(label: emailLabel, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.setThemeForButton(buttonOne: nil, buttonTwo: loginButton, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
    }
}

