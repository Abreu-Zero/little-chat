//
//  MainScreenViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 05/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainScreenViewController: UITableViewController{

    let auth = Auth.auth()
    var users: [LittleChatUsers]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = FirebaseHelper.getUsers()
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
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = users else {return 0}
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
    }
    
    

}
