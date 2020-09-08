//
//  TodayInformationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class TodayInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var sunRiseLb: UILabel!
    @IBOutlet weak var sunDownLb: UILabel!
    @IBOutlet weak var pressureLb: UILabel!
    @IBOutlet weak var humidityLb: UILabel!
    @IBOutlet weak var windSpeedLb: UILabel!
    @IBOutlet weak var feelLikeLb: UILabel!
    @IBOutlet weak var cloudsLb: UILabel!
    @IBOutlet weak var uviLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
    }
    
    static let identifier = "TodayInformationTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "TodayInformationTableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Current) {
        self.sunRiseLb.text = getDayForDate(Date(timeIntervalSince1970: Double(model.sunRise)))
        self.sunDownLb.text = getDayForDate(Date(timeIntervalSince1970: Double(model.sunSet)))
        self.pressureLb.text = "\(Int(model.pressure)) hPa"
        self.humidityLb.text = "\(Int(model.humidity))%"
        self.windSpeedLb.text = "\(model.windSpeed) km/h"
        self.feelLikeLb.text = "\(Int(model.feelsLike)-273)°C"
        self.cloudsLb.text = "\(model.clouds)"
        self.uviLb.text = "\(model.uvi)"
    }
    
    func getDayForDate(_ date: Date?) -> String {
              guard let inputDate = date else {
                  return ""
              }

              let formatter = DateFormatter()
              formatter.dateFormat = "HH:mm"
              return formatter.string(from: inputDate)
    //        "yyyy/MM/dd HH:mm"
          }
}
