//
//  WKSTableViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/22/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSTableViewController: NSObject {
    // MARK: Properties
    // --- private ---
    private var keyword: String = ""
    private var segmentIndex: Int = 0
    
    private var data = [AnyObject]()
    
    // --- public ---
    var category: String = "airline"
    var segueInfo: Bool = true
    // true  : airport/departure
    // false : airport/destination
    
    // MARK: Initializer
    override init() {
        super.init()
        
        self.initResource()
    }
    
    // MARK: alias
    typealias API = WKSFileController.FileAPI
    
    // MARK: Deinit
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK: Table view delegate and datasource
extension WKSTableViewController: UITableViewDataSource, UITableViewDelegate {

    // --- dataSource ---
    func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        var number: Int = 1
        
        // --- airport ---
        if self.category == "airport" {
            // set data
            if self.keyword == "" {
                self.data = kAirports
            } else {
                self.data = API.filter(
                    keyindex: self.segmentIndex,
                    keyword: self.keyword,
                    resource: kAirports)
            }
            
            // update
            number = data.count
        }
        
        // --- airline ---
        if self.category == "airline" {
            // set data
            if self.keyword == "" {
                self.data = kAirlines
            } else {
                self.data = API.filter(
                    keyindex: self.segmentIndex,
                    keyword: self.keyword,
                    resource: kAirlines)
            }
            
            // update
            number = self.data.count
        }
    
        return number
    }
    
    // --- delegate ---
    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
        // --- cell ---
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        // --- setup label tag ---
        let nameLabel = cell.viewWithTag(101) as! UILabel
        let codeLabel = cell.viewWithTag(102) as! UILabel
        
        if self.category == "airport" {
            let obj = data[indexPath.row] as! API.AirportInfo
            nameLabel.text = obj.Name
            codeLabel.text = obj.Code + "/" + obj.Country
        }
            
        if self.category == "airline" {
            let obj = data[indexPath.row] as! API.AirlineInfo
            nameLabel.text = obj.Name
            codeLabel.text = obj.Code + "/" + obj.TwoWordCode
        }
            
        return cell
    }
    func tableView(
        tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // airline
        if data[indexPath.row] is API.AirlineInfo {
            let airline = data[indexPath.row] as! API.AirlineInfo
            NSNotificationCenter.defaultCenter().postNotificationName(
                WKSNotification.didSelectAirline.rawValue,
                object: airline)
        }
            
        // airport
        if data[indexPath.row] is API.AirportInfo {
            let airport = data[indexPath.row] as! API.AirportInfo
            if self.segueInfo {
                // departure
                NSNotificationCenter.defaultCenter().postNotificationName(
                    WKSNotification.didSelectDeparture.rawValue,
                    object: airport)
    
            } else {
                // destination
                NSNotificationCenter.defaultCenter().postNotificationName(
                    WKSNotification.didSelectDestination.rawValue,
                    object: airport)
            }
        }
            
        // clear high light
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: Methods
extension WKSTableViewController {
    private func initResource(){
        // --- get keyword ---
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "getKeyword:",
            name: WKSNotification.didSelectKeyword.rawValue,
            object: nil)
        
        // --- get segment index ---
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "getSegmentIndex:",
            name: WKSNotification.didSelectSegmentIndex.rawValue,
            object: nil)
    }
    
    func getKeyword(notification: NSNotification?){
        if let keyword: String! = notification?.object as! String {
            self.keyword = keyword
        }
    }
    
    func getSegmentIndex(notification: NSNotification?){
        if let segmentIndex: Int! = notification?.object as! Int {
            self.segmentIndex = segmentIndex
        }
    }
}
