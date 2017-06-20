//
//  UserOrderListTableViewCell.swift
//  BookFood
//
//  Created by jiarou on 2017/6/20.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit

class UserOrderListTableViewCell: UITableViewCell {
    @IBOutlet weak var showProductName1: UILabel!
    
    @IBOutlet weak var showProductMoney1: UILabel!
    
    @IBOutlet weak var showProductNumber1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
