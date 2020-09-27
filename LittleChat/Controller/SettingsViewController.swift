//
//  SettingsViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 27/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var nightModeSwitch: UISwitch!
    
    @IBAction func changeSwitch(_ sender: Any) {
        UserDefaults.standard.setValue(nightModeSwitch.isOn, forKey: "nightmode")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nightModeSwitch.isOn = UserDefaults.standard.bool(forKey: "nightmode")
    }
}
