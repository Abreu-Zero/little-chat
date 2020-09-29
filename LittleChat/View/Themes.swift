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
            button.backgroundColor? = UIColor.yellow
        case .night:
            button.backgroundColor = UIColor.blue
        case .little:
            button.backgroundColor = UIColor.green
        }
    }
}
