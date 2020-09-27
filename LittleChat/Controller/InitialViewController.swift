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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("nightmode: \(UserDefaults.standard.bool(forKey: "nightmode"))")
        let auth = Auth.auth()
        auth.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                self.isLoggedIn = false
                return}
            self.isLoggedIn = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLoggedIn{
            self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
        }
    }

}
