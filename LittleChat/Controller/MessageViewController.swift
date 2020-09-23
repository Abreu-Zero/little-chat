//
//  MessageViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 07/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: outlets and properties
    
    var userDestination: LittleChatUsers?
    var userID: String?
    var messages: [Message] = []
    @IBOutlet weak var pageTitle: UINavigationItem!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
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
                self.messagesTableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
            }
            
        }
    }
    
    //MARK: tableView funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.sender == userID{
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
                self.messages.append(newMessage!)
                self.messagesTableView.reloadData()
            }
        }
    }
    
    //MARK: keyboard methods
    
    //TODO: show keyboard, hide keyboard, show keyboard again
    //TODO: delete text after send
    

}
