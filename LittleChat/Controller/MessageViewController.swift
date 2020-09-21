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
    @IBOutlet weak var pageTitle: UINavigationItem!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userDestination = userDestination else{
            //TODO: show alert for error
            print("Error while getting userDestination")
            navigationController?.popViewController(animated: true)
            return}
        pageTitle.title = userDestination.nickname
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        //TODO: check messages to return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentMessageCell")!
        cell.textLabel?.text = "To implement"
        return cell
        //TODO: check messages and change cell if sent or received
    }
   
    @IBAction func sendMessage(_ sender: Any) {
        //TODO: Implementation
        let message = messageTextField.text ?? ""
        guard let userID = userID else{
            print("userID invalid")
            return
        }
        FirebaseHelper.sendMessageTo(sender: userID, message: message, destination: userDestination!)
    }
    
    

}
