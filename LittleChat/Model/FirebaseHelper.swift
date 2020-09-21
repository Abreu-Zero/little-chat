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
    
    //TODO: u need to start commenting this code dude
    
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
        //FIXME: fix this duuude its unwapping nil!
        let auth = Auth.auth()
        return auth.currentUser!.uid
    }
    
    class func createUser(username: String, password: String, nickname: String, completion: @escaping (Bool, Error?) ->()){
        
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            guard let result = result else{
                print("Error while creating account")
                completion(false, error!)
                return
            }
            let database = Database.database().reference()
            let users = database.child("Users")
            let user = users.child(result.user.uid)
            user.child("Nickname").setValue(nickname)
            completion(true, nil)
        }
        
    }
    
    class func getUsers(ID: String, completion: @escaping ([LittleChatUsers]) ->()){
        var users: [LittleChatUsers] = []
        let database = Database.database().reference()
        let databaseUsers = database.child("Users")
        databaseUsers.observe(DataEventType.childAdded, with: { (data) in
            let nickname = data.childSnapshot(forPath: "Nickname").value
            let user = LittleChatUsers(id: data.key, nick: nickname as! String)
            if user.UID != ID{
                users.append(user)
            }
            completion(users)
        })
    }

    class func sendMessageTo(sender: String, message: String, destination: LittleChatUsers){
        let database = Database.database().reference()
        let user = database.child("Users").child(sender)
        let destinationDB = user.child(destination.UID)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate = formatter.string(from: Date())
        let messageUID = NSUUID().uuidString
        
        let msg = destinationDB.child(messageUID)
        msg.child("Sender").setValue(sender)
        msg.child("Message").setValue(message)
        msg.child("Time").setValue(stringDate)
        
        print("message sent to \(destination.nickname): \(message)")
        //TODO: save messages at sender too!
    }
    
    class func getMessagesFrom(sender: String, destination: LittleChatUsers, completion: @escaping ([[String : String]]) ->()){
        var messages: [[String : String]] = []
        let database = Database.database().reference()
        let dataMessages = database.child("Users").child(sender).child(destination.UID)
        dataMessages.observe(DataEventType.childAdded, with: { (data) in
            
            let message = ["UID": data.key, "Message": data.value(forKey: "Message") as! String, "Sender": data.value(forKey: "Sender") as! String, "Time": data.value(forKey: "Time") as! String]
            
            messages.append(message)
            completion(messages)
        })
        
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
