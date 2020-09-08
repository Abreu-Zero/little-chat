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

class FirebaseHelper{
    
    class func saveImageToFirebaseStorage(image: UIImage){
        let storage = Storage.storage().reference()
        let images = storage.child("Images")
        
        let data = image.pngData()!
        
        images.child("Image.png").putData(data, metadata: nil) { (data, error) in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            print("Success at saveImageToFirebaseStorage \n\(String(describing: data.name))")
        }
        
        
    }
}
