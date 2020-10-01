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
    
    class func setThemeForButton(buttonOne: UIButton?, buttonTwo: UIButton?){
        
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))
        
        if let buttonOne = buttonOne{
            switch theme{
            case .desert:
                buttonOne.backgroundColor? = UIColor.init(red: 1/255*102, green: 1/255*102, blue: 0, alpha: 1)
                buttonOne.setTitleColor(UIColor.white, for: UIControl.State.normal)
            case .night:
                buttonOne.backgroundColor = UIColor.init(red: 1/255*32, green: 1/255*32, blue: 1/255*32, alpha: 1)
                buttonOne.setTitleColor(UIColor.white, for: UIControl.State.normal)
            case .little:
                buttonOne.backgroundColor = UIColor.systemTeal
                buttonOne.setTitleColor(UIColor.black, for: UIControl.State.normal)
            default:
                break
            }
        }
        
        if let buttonTwo = buttonTwo{
            switch theme{
            case .desert:
                buttonTwo.backgroundColor? = UIColor.init(red: 1/255*153, green: 1/255*153, blue: 0, alpha: 1)
                buttonTwo.setTitleColor(UIColor.white, for: UIControl.State.normal)
            case .night:
                buttonTwo.backgroundColor = UIColor.init(red: 1/255*64, green: 1/255*64, blue: 1/255*64, alpha: 1)
                buttonTwo.setTitleColor(UIColor.white, for: UIControl.State.normal)
            case .little:
                buttonTwo.backgroundColor = UIColor.init(red: 1/255*86, green: 1/255*192, blue: 1/255*136, alpha: 1)
                buttonTwo.setTitleColor(UIColor.black, for: UIControl.State.normal)
            default:
                break
            }
        }
        
    }
    
    class func setThemeForView(view: UIView){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))

        switch theme{
        case .desert:
            view.backgroundColor? = UIColor.init(red: 1, green: 1, blue: 1/255*204, alpha: 1)
        case .night:
            view.backgroundColor = UIColor.darkGray
        case .little:
            view.backgroundColor = UIColor.white
        default:
            break
        }
    }
    
    class func SetThemeForLabel(label: UILabel){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))

        switch theme{
        case .desert:
            label.textColor? = UIColor.black
        case .night:
            label.textColor = UIColor.white
        case .little:
            label.textColor = UIColor.black
        default:
            break
        }
    }
}
