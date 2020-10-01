//
//  Themes.swift
//  LittleChat
//
//  Created by Henrique Abreu on 29/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import Foundation
import UIKit

class Themes{
    
    enum Theme: Int{
        case desert = 3
        case night = 2
        case little = 1
    }
    
    class func setThemeForButton(button: UIButton, theme: Theme){
        switch theme{
        case .desert:
            button.backgroundColor? = UIColor.init(red: 0.204, green: 0.204, blue: 0, alpha: 1)
            button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        case .night:
            button.backgroundColor = UIColor.blue
        case .little:
            button.backgroundColor = UIColor.green
        }
    }
    
    class func setThemeForView(view: UIView, theme: Theme){
        switch theme{
        case .desert:
            view.backgroundColor? = UIColor.init(red: 0.255, green: 0.255, blue: 0.204, alpha: 1)
        case .night:
            view.backgroundColor = UIColor.blue
        case .little:
            view.backgroundColor = UIColor.green
        }
    }
    
    class func SetThemeForLabel(label: UILabel, theme: Theme){
        switch theme{
        case .desert:
            label.backgroundColor? = UIColor.init(red: 0.204, green: 0.204, blue: 0, alpha: 1)
        case .night:
            label.backgroundColor = UIColor.blue
        case .little:
            label.backgroundColor = UIColor.green
        }
    }
}
