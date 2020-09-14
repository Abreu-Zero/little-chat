//
//  NewMessageViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 07/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageID = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickImage(_ sender: Any) {wichPicker(.photoLibrary)}
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {wichPicker(.camera)}
    
    func wichPicker(_ source : UIImagePickerController.SourceType){
        // changes the sourceType between camera and photos app
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func send(_ sender: Any) {
        guard let image = imageView.image else {return}
        print(FirebaseHelper.saveImageToFirebaseStorage(image: image, id: imageID))
        navigationController?.popViewController(animated: true)
    }
    
    // TODO: enable keyboard hiding
    // TODO: hide image or message
    // TODO: contact selection

}
