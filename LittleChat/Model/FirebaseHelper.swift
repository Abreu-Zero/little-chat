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
    
    class func getUsers() -> [LittleChatUsers]{
        //TODO: implementation
        let testUser = LittleChatUsers(id: "42", nick: "Test")
        return [testUser]
    }
    
    class func saveImageToFirebaseStorage(image: UIImage, id: String) -> String{
        let storage = Storage.storage().reference()
        let images = storage.child("Images")
        var path = "Nothing to see here just some caveman debbuging"
        
        let data = image.pngData()!

        images.child("photo\(id).png").putData(data, metadata: nil) { (data, error) in
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                path = data.path!
            }
        }
        return path
        
    }
}
