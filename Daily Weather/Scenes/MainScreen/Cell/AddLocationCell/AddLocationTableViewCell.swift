//
//  AddLocationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class AddLocationTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "AddLocationTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "AddLocationTableViewCell",
                     bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
