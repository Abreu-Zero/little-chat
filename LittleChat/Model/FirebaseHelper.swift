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
    
    class func loginUser(username: String, password: String, completion: @escaping (Bool, Error?) ->()){
        
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            guard let result = result else{
                completion(false, error)
                return
            }
            print("Login successful, \(result.user.email!)")
            completion(true, nil)
        }
    }
    
    class func getUserID() -> String {
        let auth = Auth.auth()
        return auth.currentUser?.uid ?? "Invalid UID"
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

    class func sendMessageTo(sender: String, message: String, destination: LittleChatUsers, completion: @escaping ((Bool) -> ())){
        let database = Database.database().reference()
        let user = database.child("Users").child(sender)
        let destinationDB = user.child(destination.UID)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate = formatter.string(from: Date())
        let messageUID = NSUUID().uuidString
        
        let receiver = database.child("Users").child(destination.UID)
        let saveSender = receiver.child(sender)
        let msg2 = saveSender.child(messageUID)
        let msg = destinationDB.child(messageUID)
        
        let msgDict = ["Sender": sender, "Message": message, "Time": stringDate]
        msg.updateChildValues(msgDict) { (error, database) in
            if let error = error{
                print("ERROR while saving message to DB \(error.localizedDescription)")
            } else{
                
                
                msg2.updateChildValues(msgDict) { (error, database) in
                    if let error = error{
                        print("ERROR while saving message to DB \(error.localizedDescription)")
                    } else{
                        completion(true)
                    }
                }
            }
        }
    }
    
    func saveMessage(sender: String, message: String, destination: String){
        //TODO: refactor sendMessageTo
    }
    
    class func getMessagesFrom(sender: String, destination: LittleChatUsers, completion: @escaping ([Message]) ->()){
        var messages: [Message] = []
        let database = Database.database().reference()
        let dataMessages = database.child("Users").child(sender).child(destination.UID)
        dataMessages.observe(DataEventType.childAdded, with: { (data) in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.date(from: data.childSnapshot(forPath: "Time").value as! String)
            let message = Message(uid: data.key, text: data.childSnapshot(forPath: "Message").value as! String, date:  date!, sender: data.childSnapshot(forPath: "Sender").value as! String)
            
            messages.append(message)
            messages = messages.sorted { $0.date > $1.date }
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
