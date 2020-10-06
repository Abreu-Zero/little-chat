//
//  MessageViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 07/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import CoreData

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //MARK: outlets and properties

    var dataController = DataController(modelName: "LittleChat")
    var userDestination: LittleChatUsers?
    var userID: String?
    var messages: [Message] = []
    var activeTextField: UITextField?
    var viewIsMoved = false
    var savedText: TextMessage?
    @IBOutlet weak var pageTitle: UINavigationItem!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var sendBgView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messageTextField.delegate = self
        dataController.load()
        
        guard let userDestination = userDestination else{
            //TODO: show alert for error
            print("Error while getting userDestination")
            navigationController?.popViewController(animated: true)
            return}
        pageTitle.title = userDestination.nickname
        
        
        FirebaseHelper.getMessagesFrom(sender: userID!, destination: userDestination) { (dataMessages) in
            DispatchQueue.main.async {
                self.messages = dataMessages
                self.messagesTableView.reloadData()
                
                let indexPath = NSIndexPath(row: self.messages.count - 1, section: 0)
                self.messagesTableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
            }
            
        }
        
        let fetch : NSFetchRequest<TextMessage> = TextMessage.fetchRequest()
        
        guard let result = try? dataController.viewContext.fetch(fetch) else{return}
        if result.count > 0{
            messageTextField.text = result[0].text
            savedText = result[0]
        }
        
    }
    
    //Subscribing and unsubs to show hide keyboard
    
    override func viewWillAppear(_ animated: Bool) {
        dataController.autoSave(interval: 5)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        loadTheme()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: tableView funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.sender == userID{ //if sender's ID == user ID, it's a sent msg
            let cell = tableView.dequeueReusableCell(withIdentifier: "sentMessageCell")! as! MessageTableViewCell
            cell.sentMessage.text = message.text
            Themes.setThemeForConversationCell(cell: cell, isSentMessage: true)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell")! as! MessageTableViewCell
            cell.receivedMessage.text = message.text
            Themes.setThemeForConversationCell(cell: cell, isSentMessage: false)
            return cell
        }
    }
   
    @IBAction func sendMessage(_ sender: Any) {
        guard let message = messageTextField.text else{return}
        if message == "" {return}
        guard let userID = userID else{
            print("userID invalid")
            return
        }
        FirebaseHelper.sendMessageTo(sender: userID, message: message, destination: userDestination!) { (success, newMessage) in
            if success{
                guard let newMessage = newMessage else{return}
                self.messages.append(newMessage)
                guard let savedText = self.savedText else{return}
                self.dataController.viewContext.delete(savedText)
                do{
                    try self.dataController.viewContext.save() //TODO: polish this
                }catch{return}
            }
        }
        self.messageTextField.text = ""
    }
    
    //MARK: keyboard methods
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if !viewIsMoved{
            var shouldMoveViewUp = false

            // if active text field is not nil
            if let activeTextField = activeTextField {

              let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
              
              let topOfKeyboard = self.view.frame.height - getKeyboardHeight(notification)

              // if the bottom of Textfield is below the top of keyboard, move up
              if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
              }
            }
            if(shouldMoveViewUp){
                view.frame.origin.y -= getKeyboardHeight(notification)
                viewIsMoved = true
            }
        }
        
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
        viewIsMoved = false
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        //here we are checking the keyboard height to move the view so we can see the text
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    //MARK: textField methods
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        savedText = TextMessage(context: dataController.viewContext)
        
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        savedText!.text = messageTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage(self)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func loadTheme(){
        Themes.setThemeForView(view: bgView)
        Themes.setThemeForView(view: sendBgView)
        Themes.setThemeForView(view: messagesTableView)
    }

}
