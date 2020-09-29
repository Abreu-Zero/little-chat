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
    @IBOutlet weak var desertSwitch: UISwitch!
    @IBOutlet weak var littleSwitch: UISwitch!
    
    var switchs: [UISwitch]?
    
    @IBAction func changeSwitchNight(_ sender: Any) {
        desertSwitch.isOn = false
        littleSwitch.isOn = false
        UserDefaults.standard.setValue(2, forKey: "theme")
    }
    
    @IBAction func changeSwitchDesert(_ sender: Any) {
        nightModeSwitch.isOn = false
        littleSwitch.isOn = false
        UserDefaults.standard.setValue(3, forKey: "theme")
    }
    
    @IBAction func changeSwitchLittle(_ sender: Any) {
        desertSwitch.isOn = false
        nightModeSwitch.isOn = false
        UserDefaults.standard.setValue(1, forKey: "theme")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchs = [nightModeSwitch, desertSwitch, littleSwitch]
        
        nightModeSwitch.isOn = UserDefaults.standard.integer(forKey: "theme") == 2
        desertSwitch.isOn = UserDefaults.standard.integer(forKey: "theme") == 3
        littleSwitch.isOn = UserDefaults.standard.integer(forKey: "theme") == 1
    }
}
