//
//  ListLocationViewController.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/6/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import UIKit

class ListLocationViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var listLocationTable: UITableView!
    var currentModels : Current!
    var listCity = [City]()
    
    override func viewDidLoad() {
        listLocationTable.register(LocationTableViewCell.nib(), forCellReuseIdentifier: LocationTableViewCell.identifier)
        listLocationTable.dataSource = self
        listLocationTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listCity.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as! LocationTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AddLocationTableViewCell.identifier, for: indexPath) as! AddLocationTableViewCell
        return cell
    }
    
}
