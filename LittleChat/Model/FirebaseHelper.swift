//
//  FirebaseHelper.swift
//  LittleChat
//
//  Created by Henrique Abreu on 08/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FirebaseHelper{
    
    class func loginUser(username: String, password: String) -> Error?{
        var toReturn: Error?
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil{
                toReturn = error
            }
        }
        
        return toReturn
    }
    
    class func getUserID() -> String {
        let auth = Auth.auth()
        return auth.currentUser!.uid
    }
    
    class func createUser(username: String, password: String, nickname: String) -> Error?{
        var toReturn : Error?        
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            guard let result = result else{
                toReturn = error
                return
            }
            let database = Database.database().reference()
            let users = database.child("Users")
            users.child(result.user.uid).setValue(nickname)
        }
        return toReturn
    }
    
    class func getUsers(ID: String, completion: @escaping ([LittleChatUsers]) ->()){
        var users: [LittleChatUsers] = []
        let database = Database.database().reference()
        let databaseUsers = database.child("Users")
        databaseUsers.observe(DataEventType.childAdded, with: { (data) in
            let user = LittleChatUsers(id: data.key, nick: data.value as! String)
            if user.UID != ID{
                users.append(user)
            }
            completion(users)
        })
    }

    class func sendMessageTo(message: String, destination: LittleChatUsers){
        print("message sent to \(destination.nickname): \(message)")
    }
    
    class func logout() -> Bool{
        do{
            try Auth.auth().signOut()
            return true
        } catch{
            return false
        }
    }

}
