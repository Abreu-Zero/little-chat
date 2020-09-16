//
//  Alert.swift
//  LittleChat
//
//  Created by Henrique Abreu on 16/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class BaseAlert{
    
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    func getAlert() -> UIAlertController{
        let alert = UIAlertController(title: self.title, message: self.message, preferedStyle: .alert)
        let action 
        
    }
}
