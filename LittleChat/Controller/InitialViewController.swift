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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let auth = Auth.auth()
        
        auth.addStateDidChangeListener { (auth, user) in
            guard user != nil else {return}
            self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
        }
    }

}
