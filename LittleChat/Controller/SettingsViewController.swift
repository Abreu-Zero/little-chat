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
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var desertSwitch: UISwitch!
    @IBOutlet weak var desertLabel: UILabel!
    @IBOutlet weak var littleSwitch: UISwitch!
    @IBOutlet weak var littleLabel: UILabel!
    @IBOutlet var bgView: UIView!
    
    var switchs: [UISwitch]?
    
    @IBAction func changeSwitchNight(_ sender: Any) {
        desertSwitch.isOn = false
        littleSwitch.isOn = false
        UserDefaults.standard.setValue(2, forKey: "theme")
        loadTheme()
    }
    
    @IBAction func changeSwitchDesert(_ sender: Any) {
        nightModeSwitch.isOn = false
        littleSwitch.isOn = false
        UserDefaults.standard.setValue(3, forKey: "theme")
        loadTheme()
    }
    
    @IBAction func changeSwitchLittle(_ sender: Any) {
        desertSwitch.isOn = false
        nightModeSwitch.isOn = false
        UserDefaults.standard.setValue(1, forKey: "theme")
        loadTheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchs = [nightModeSwitch, desertSwitch, littleSwitch]
        
        nightModeSwitch.isOn = UserDefaults.standard.integer(forKey: "theme") == 2
        desertSwitch.isOn = UserDefaults.standard.integer(forKey: "theme") == 3
        littleSwitch.isOn = UserDefaults.standard.integer(forKey: "theme") == 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTheme()
    }
    
    func loadTheme(){
        Themes.setThemeForView(view: bgView)
        Themes.setThemeForRadio(radio: desertSwitch)
        Themes.setThemeForRadio(radio: nightModeSwitch)
        Themes.setThemeForRadio(radio: littleSwitch)
        Themes.SetThemeForLabel(label: desertLabel)
        Themes.SetThemeForLabel(label: nightLabel)
        Themes.SetThemeForLabel(label: littleLabel)
    }
}
