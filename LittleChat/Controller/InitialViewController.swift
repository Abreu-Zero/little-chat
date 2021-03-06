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
    var dataController: DataController?
    
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
        Themes.setThemeForButton(buttonOne: createAccountButton, buttonTwo: loginButton)
        Themes.setThemeForView(view: view)
        Themes.SetThemeForLabel(label: titleLabel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "autoLoginSegue"{
            let targetVC = segue.destination as! MainScreenViewController
            targetVC.dataController = dataController
        }else if segue.identifier == "toCreateAccountSegue"{
            let targetVC = segue.destination as! CreateAccountViewController
            targetVC.dataController = dataController
        }else{
            let targetVC = segue.destination as! LoginViewController
            targetVC.dataController = dataController
        }
    }

}
