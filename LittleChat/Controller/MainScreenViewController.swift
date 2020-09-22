//
//  MainScreenViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 05/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class MainScreenViewController: UITableViewController{
    
    //TODO: add search bar!!!

    var userID: String!
    var users: [LittleChatUsers] = []
    var chat: LittleChatUsers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = FirebaseHelper.getUserID()
        FirebaseHelper.getUsers(ID: userID) { (data: [LittleChatUsers]) in
            self.users = data
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        if FirebaseHelper.logout(){
            navigationController?.popToRootViewController(animated: true)
        } else{
            print("ERROR: logout Unsuccessful")
        }
    }
    
    //MARK: tableView funcs
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chat = users[indexPath.row]
        performSegue(withIdentifier: "toChat", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].nickname
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat"{
            let destination = segue.destination as! MessageViewController
            guard let chat = chat else{return}
            destination.userDestination = chat //injecting user and destination to msg
            destination.userID = self.userID
        }
    }
    
    

}
