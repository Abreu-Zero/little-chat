//
//  MessageViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 07/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //MARK: outlets and properties
    
    var userDestination: LittleChatUsers?
    var userID: String?
    var messages: [Message] = []
    var activeTextField: UITextField?
    @IBOutlet weak var pageTitle: UINavigationItem!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messageTextField.delegate = self
        
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
    }
    
    //Subscribing and unsubs to show hide keyboard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
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
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell")! as! MessageTableViewCell
            cell.receivedMessage.text = message.text
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
            }
        }
        self.messageTextField.text = ""
    }
    
    //MARK: keyboard methods
    
    @objc func keyboardWillShow(_ notification:Notification) {

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
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage(self)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
    

}
