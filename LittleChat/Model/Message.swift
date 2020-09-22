//
//  Message.swift
//  LittleChat
//
//  Created by Henrique Abreu on 22/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import Foundation

class Message{
    
    var uid: String
    var text: String
    var date: Date
    var sender: String
    
    init(uid: String, text: String, date: Date, sender: String) {
        self.uid = uid
        self.text = text
        self.date = date
        self.sender = sender
    }
}
