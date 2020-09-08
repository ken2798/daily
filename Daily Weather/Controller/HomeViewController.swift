//
//  HomeViewController.swift
//  WeatherAppProject1
//
//  Created by Nguyen Tien Cong on 8/5/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var currentTempLb: UILabel!
    @IBOutlet weak var currentLocationLb: UILabel!
    @IBOutlet weak var currentStatusLb: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    var dailyModels = [Daily]()
    var hourlyModels = [Hourly]()
    var currentModels : Current?
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.register(TodayDetailTableViewCell.nib(), forCellReuseIdentifier: TodayDetailTableViewCell.identifier)
        table.register(TodayInformationTableViewCell.nib(), forCellReuseIdentifier: TodayInformationTableViewCell.identifier)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
        getWeatherData()
        setupCurrentView()
    }
    
    func setupLocation(){
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherData () {
        CoordinateData.coor.updateCoor()
        WeatherData.weather.fetchCoursesJSON(with: CoordinateData.coor.lon, lat: CoordinateData.coor.lat, completion: {(res) in
            switch res {
            case .success(let result) :
                self.currentModels = result.current
                self.dailyModels = result.daily
                self.hourlyModels = result.hourly
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            case .failure(_) :
                print("loi")
            }
        })
    }
    
    func setupCurrentView(){
        CoordinateData.coor.updateCoor()
        let lat = CoordinateData.coor.lat
        let lon = CoordinateData.coor.lon
        LocationData.location.getAddressFromLatLon(lat: lat, lon: lon) { ( addressString, err ) in
            if let addressString = addressString {
                self.currentLocationLb.text = addressString
            }
            
        }
        WeatherData.weather.fetchCoursesJSON(with: lon, lat: lat, completion: {(res) in
            switch res {
            case .success(let result) :
                self.currentModels = result.current
                guard let cr = self.currentModels else {return}
                DispatchQueue.main.async {
                    self.currentTempLb.text = " \(Int(cr.temperature)-273)°"
                    self.currentStatusLb.text = cr.weather[0].description
                }
            case .failure(_) :
                print("loi")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return dailyModels.count
        }
        if section == 2 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            cell.configure(with: dailyModels[indexPath.row])
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayDetailTableViewCell.identifier, for: indexPath) as! TodayDetailTableViewCell
            guard let cr = currentModels else { return cell }
            cell.configure(with: cr)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayInformationTableViewCell.identifier, for: indexPath) as! TodayInformationTableViewCell
        guard let cr = currentModels else { return cell }
        cell.configure(with: cr)
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 1
     }
     
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return ""
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        if indexPath.section == 1 {
            return 50
        }
        if indexPath.section == 2 {
            return 100
        }
        return 423
    }
    
}


