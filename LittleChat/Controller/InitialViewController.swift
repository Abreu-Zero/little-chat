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
        FirebaseHelper.autoLogin { (isUserLogged) in
            self.isLoggedIn = isUserLogged
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Themes.setThemeForButton(button: createAccountButton, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.setThemeForButton(button: loginButton, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoggedIn{
            self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
        }
    }

}
