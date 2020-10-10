//
//  Themes.swift
//  LittleChat
//
// This class handle all the Theme changes
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
    
    //MARK: Button themes
    
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
    
    //MARK: contact themes
    
    class func setThemeForContactCell(cell: UITableViewCell){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))

        switch theme{
        case .desert:
            cell.textLabel?.textColor? = UIColor.black
            cell.backgroundColor = UIColor.init(red: 1/255*153, green: 1/255*153, blue: 0, alpha: 1)
        case .night:
            cell.textLabel?.textColor? = UIColor.white
            cell.backgroundColor =  UIColor.init(red: 1/255*64, green: 1/255*64, blue: 1/255*64, alpha: 1)
        case .little:
            cell.textLabel?.textColor? = UIColor.black
            cell.backgroundColor = UIColor.init(red: 1/255*86, green: 1/255*192, blue: 1/255*136, alpha: 1)
        default:
            break
        }
    }
    
    class func setThemeForConversationCell(cell: MessageTableViewCell, isSentMessage: Bool){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))
        
        if isSentMessage{
            switch theme{
            case .desert:
                cell.sentMessage?.textColor? = UIColor.black
                cell.sentContentView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1/255*204, alpha: 1)
                cell.sentBgView.backgroundColor = UIColor.init(red: 1/255*102, green: 1/255*102, blue: 0, alpha: 1)
            case .night:
                cell.sentMessage?.textColor? = UIColor.white
                cell.sentContentView.backgroundColor = UIColor.darkGray
                cell.sentBgView.backgroundColor =  UIColor.init(red: 1/255*32, green: 1/255*32, blue: 1/255*32, alpha: 1)
            case .little:
                cell.sentMessage?.textColor? = UIColor.black
                cell.sentContentView.backgroundColor = UIColor.white
                cell.sentBgView.backgroundColor = UIColor.systemTeal
            default:
                break
            }
        }else{
            switch theme{
            case .desert:
                cell.receivedMessage?.textColor? = UIColor.black
                cell.receivedContentView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1/255*204, alpha: 1)
                cell.receivedBgView.backgroundColor = UIColor.init(red: 1/255*153, green: 1/255*153, blue: 0, alpha: 1)
            case .night:
                cell.receivedMessage?.textColor? = UIColor.white
                cell.receivedContentView.backgroundColor = UIColor.darkGray
                cell.receivedBgView.backgroundColor =  UIColor.init(red: 1/255*64, green: 1/255*64, blue: 1/255*64, alpha: 1)
            case .little:
                cell.receivedMessage?.textColor? = UIColor.black
                cell.receivedContentView.backgroundColor = UIColor.white
                cell.receivedBgView.backgroundColor = UIColor.init(red: 1/255*86, green: 1/255*192, blue: 1/255*136, alpha: 1)
            default:
                break
            }
        }
    }
    
    class func setThemeForSearchBar(searchBar : UISearchBar){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))
        
        switch theme{
        case .desert:
            searchBar.barTintColor = UIColor.init(red: 1, green: 1, blue: 1/255*204, alpha: 1)
        case .night:
            searchBar.barTintColor = UIColor.darkGray
        case .little:
            searchBar.barTintColor = UIColor.white
        default:
            break
        }
    }
    
    class func setThemeForRadio(radio: UISwitch){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))
        
        switch theme{
        case .desert:
            radio.onTintColor = UIColor.init(red: 1/255*153, green: 1/255*153, blue: 0, alpha: 1)
        case .night:
            radio.onTintColor = UIColor.init(red: 1/255*64, green: 1/255*64, blue: 1/255*64, alpha: 1)
        case .little:
            radio.onTintColor = UIColor.init(red: 1/255*86, green: 1/255*192, blue: 1/255*136, alpha: 1)
        default:
            break
        }
    }
    
    class func setThemeForTextField(textField: UITextField){
        let theme = Theme(rawValue: UserDefaults.standard.integer(forKey: "theme"))

        switch theme{
        case .desert:
            textField.textColor? = UIColor.black
            textField.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1/255*204, alpha: 1)
        case .night:
            textField.textColor = UIColor.white
            textField.backgroundColor = UIColor.darkGray
        case .little:
            textField.textColor = UIColor.black
            textField.backgroundColor = UIColor.white
        default:
            break
        }
    }
}
