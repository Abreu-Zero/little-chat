//
//  InitialViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 05/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialViewController: UIViewController {

    var isLoggedIn = false
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let auth = Auth.auth()
        auth.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                self.isLoggedIn = false
                return}
            self.isLoggedIn = true
        }
        
        Themes.setThemeForButton(button: createAccountButton, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLoggedIn{
            self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
        }
    }

}
