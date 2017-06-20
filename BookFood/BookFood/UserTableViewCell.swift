//
//  UserTableViewCell.swift
//  BookFood
//
//  Created by jiarou on 2017/6/20.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showOrder: UILabel!
    
    @IBOutlet weak var showStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
