//
//  LocationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/6/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var TemperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "LocationTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "LocationTableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Current) {
        self.TemperatureLabel.text = "\(Int(model.temperature)-273)°"
        self.timeLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
    }

    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Monday
        return formatter.string(from: inputDate)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
