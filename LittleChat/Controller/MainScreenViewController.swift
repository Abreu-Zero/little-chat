//
//  MainScreenViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 05/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainScreenViewController: UITableViewController{

    let auth = Auth.auth()
    var users: [LittleChatUsers] = []
    var chat = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseHelper.getUsers { (data: [LittleChatUsers]) in
            self.users = data
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        do{
            try auth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch{
            print("something went wrong with the logout, but why?")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chat = users[indexPath.row].nickname
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
            let destination = segue.destination as! NewMessageViewController
            destination.chat = self.chat
        }
    }
    
    

}
