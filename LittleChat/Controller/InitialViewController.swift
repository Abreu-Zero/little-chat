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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseHelper.autoLogin { (isUserLogged) in
            self.isLoggedIn = isUserLogged
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTheme()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoggedIn{
            self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
        }
    }
    
    func loadTheme(){
        Themes.setThemeForButton(button: createAccountButton, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.setThemeForButton(button: loginButton, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.setThemeForView(view: view, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
        Themes.SetThemeForLabel(label: titleLabel, theme: Themes.Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))!)
    }

}
