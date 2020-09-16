//
//  LittleChatUsers.swift
//  LittleChat
//
//  Created by Henrique Abreu on 16/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import Foundation

class LittleChatUsers{
    let UID: String
    let nickname: String
    
    init(id: String, nick: String) {
        self.UID = id
        self.nickname = nick
    }
}
