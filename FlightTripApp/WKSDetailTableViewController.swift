//
//  WKSDetailTableViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/25/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//


// MARK: Memo - http://so-zou.jp/web-app/tech/web-api/google/map/geocoding.htm#no4
// MARK: Memo - http://api.openweathermap.org/data/2.5/weather?q=London&mode=json

import UIKit
import MapKit
import CoreLocation

class WKSDetailTableViewController: NSObject {
    // MARK: Properties
    private var info: WKSInformation!
    
    // MARK: initializer
    override init() {
        super.init()
        
    }
    init(info: WKSInformation){
        super.init()
        
        self.info = info
    }
}

// MARK: Configure Cell
extension WKSDetailTableViewController {
    private func configureTableCell(weatherImg img: UIImageView, label: UILabel, map: MKMapView, departure: Bool) {
        if departure {
            label.text = self.info.departure.Name
        } else {
            label.text = self.info.destination.Name
        }
    }
}

// MARK: tableView dataSource and delegate
extension WKSDetailTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // --- dataSource ---
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // --- delegate ---
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:     // departure
            let cell = tableView.dequeueReusableCellWithIdentifier("DepCell")!
            let weather = cell.viewWithTag(WKSDetailViewDepTableCell.Weather.rawValue) as! UIImageView
            let departure = cell.viewWithTag(WKSDetailViewDepTableCell.Depature.rawValue) as! UILabel
            let map = cell.viewWithTag(WKSDetailViewDepTableCell.Map.rawValue) as! MKMapView
            
            // --- cell configuration ---
            self.configureTableCell(weatherImg: weather, label: departure, map: map, departure: true)
            
            return cell
            
        default:    // destination
            let cell = tableView.dequeueReusableCellWithIdentifier("DesCell")!
            let weather = cell.viewWithTag(WKSDetailViewDesTableCell.Weather.rawValue) as! UIImageView
            let destination = cell.viewWithTag(WKSDetailViewDesTableCell.Destination.rawValue) as! UILabel
            let map = cell.viewWithTag(WKSDetailViewDesTableCell.Map.rawValue) as! MKMapView
            
            // --- cell configuration ---
            self.configureTableCell(weatherImg: weather, label: destination, map: map, departure: false)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
}
