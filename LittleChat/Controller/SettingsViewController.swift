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
        checkThemes()
    }
    
    @IBAction func changeSwitchDesert(_ sender: Any) {
        nightModeSwitch.isOn = false
        littleSwitch.isOn = false
        checkThemes()
    }
    
    @IBAction func changeSwitchLittle(_ sender: Any) {
        desertSwitch.isOn = false
        nightModeSwitch.isOn = false
        checkThemes()
    }
    
    func checkThemes(){
        UserDefaults.standard.setValue(nightModeSwitch.isOn, forKey: "nightTheme")
        UserDefaults.standard.setValue(littleSwitch.isOn, forKey: "littleTheme")
        UserDefaults.standard.setValue(desertSwitch.isOn, forKey: "desertTheme")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchs = [nightModeSwitch, desertSwitch, littleSwitch]
        
        nightModeSwitch.isOn = UserDefaults.standard.bool(forKey: "nightTheme")
        desertSwitch.isOn = UserDefaults.standard.bool(forKey: "desertTheme")
        littleSwitch.isOn = UserDefaults.standard.bool(forKey: "littleTheme")
    }
}
