//
//  OrderTableViewCell.swift
//  BookFood
//
//  Created by jiarou on 2017/6/19.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var showProductName: UILabel!
    
    @IBOutlet weak var showProductMoney: UILabel!
    @IBOutlet weak var showProductNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
