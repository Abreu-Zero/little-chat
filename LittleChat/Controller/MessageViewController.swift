//
//  MessageViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 07/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        print("number of messages: \(messages.count)")
        guard let userDestination = userDestination else{
            //TODO: show alert for error
            print("Error while getting userDestination")
            navigationController?.popViewController(animated: true)
            return}
        
        pageTitle.title = userDestination.nickname
        FirebaseHelper.getMessagesFrom(sender: userID!, destination: userDestination) { (dataMessages) in
            print("getting messages")
            DispatchQueue.main.async {
                self.messages = dataMessages
                self.messagesTableView.reloadData()
                print("number of messages: \(self.messages.count)")
            }
            
        }
    }
    
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
        //TODO: Implementation
        let message = messageTextField.text ?? ""
        guard let userID = userID else{
            print("userID invalid")
            return
        }
        FirebaseHelper.sendMessageTo(sender: userID, message: message, destination: userDestination!)
        FirebaseHelper.getMessagesFrom(sender: userID, destination: userDestination!) { (dataMessages) in
            self.messages = dataMessages
            self.messagesTableView.reloadData()
        }
    }
    
    

}
