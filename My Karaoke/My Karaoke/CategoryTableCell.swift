//
//  CategoryTableCell.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/18.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import Foundation
import UIKit

class CategoryTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
