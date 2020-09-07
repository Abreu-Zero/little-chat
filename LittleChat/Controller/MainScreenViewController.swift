//
//  MainScreenViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 05/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainScreenViewController: UIViewController {

    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    @IBAction func logout(_ sender: Any) {
        do{
            try auth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch{
            print("something went wrong with the logout, but why?")
        }
    }
    
    // TODO: add new contact
    // TODO: table view logic
    // TODO: open conversation logic
    

}
