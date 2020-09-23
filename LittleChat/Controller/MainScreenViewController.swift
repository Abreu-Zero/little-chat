//
//  MainScreenViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 05/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var userID: String!
    var users: [LittleChatUsers] = []
    var savedUsers: [LittleChatUsers] = []
    var chat: LittleChatUsers?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        activityIndicator.startAnimating()
        userID = FirebaseHelper.getUserID()
        
        FirebaseHelper.getUsers(ID: userID) { (data: [LittleChatUsers]) in
            self.users = data
            self.savedUsers = self.users
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chat = users[indexPath.row]
        performSegue(withIdentifier: "toChat", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].nickname
        return cell
    }
    
    // MARK: segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat"{
            let destination = segue.destination as! MessageViewController
            guard let chat = chat else{return}
            destination.userDestination = chat //injecting user and destination to msg
            destination.userID = self.userID
        }
    }
    
    //MARK: searchbar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.users = self.savedUsers
            tableView.reloadData()
        }else{
            self.users = []
            for user in savedUsers{
                if user.nickname.contains(searchText){
                    self.users.append(user)
                }
            tableView.reloadData()
            }
        }
            
    }
}
