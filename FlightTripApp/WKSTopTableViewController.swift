//
//  WKSTopTableViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/24/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSTopTableViewController: NSObject {
    // MARK: Properties
    private var infos = [WKSInformation]()
    
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(infos: [WKSInformation] ){
        super.init()
        self.infos = infos
    }
}

// MARK: tableView DataSource and Delegate
extension WKSTopTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // --- dataSource ---
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let info = self.infos[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        // --- airline label ---
        let airline = cell.viewWithTag(WKSTopViewTableCell.Airline.rawValue) as! UILabel
        airline.text = info.airline.Name
        
        // --- departure label ---
        let departure = cell.viewWithTag(WKSTopViewTableCell.Departure.rawValue) as! UILabel
        departure.text = info.departure.Name
        
        // --- destination label ---
        let destination = cell.viewWithTag(WKSTopViewTableCell.Destination.rawValue) as! UILabel
        destination.text = info.destination.Name
        
        // --- date label ---
        let date = cell.viewWithTag(WKSTopViewTableCell.Calender.rawValue) as! UILabel
        date.text = info.dateStr
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // pickup selected info object
        let info = self.infos[indexPath.row]
        
        // post selected info object to notification
        NSNotificationCenter.defaultCenter().postNotificationName(
            WKSNotification.didSelectInfo.rawValue,
            object: info)
            
        // deselect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150.0
    }
}
