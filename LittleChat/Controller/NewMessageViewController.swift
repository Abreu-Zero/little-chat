//
//  NewMessageViewController.swift
//  LittleChat
//
//  Created by Henrique Abreu on 07/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {

    var chat = ""
    @IBOutlet weak var pageTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.title = chat

        // Do any additional setup after loading the view.
    }
    
   
    
    // TODO: enable keyboard hiding
    // TODO: hide image or message
    // TODO: remove image functionalities and add message ones
    // TODO: contact selection
    // TODO: change this one, we wont be using it 

}
