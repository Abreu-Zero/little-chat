//
//  MessageTableViewCell.swift
//  LittleChat
//
//  Created by Henrique Abreu on 21/09/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var sentMessage: UILabel!
    @IBOutlet weak var receivedMessage: UILabel!
    
    
    
    
    
    
}
