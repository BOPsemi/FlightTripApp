//
//  WKSAirportViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/21/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSAirportViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var airport: UILabel!
    @IBOutlet weak var airportCode: UILabel!
    
    
    // Properties
    private var collectionViewController: WKSIndexCollectionViewController!
    private var tableViewController: WKSTableViewController!
    
    var segueInfo: Bool = true
    // true  : departure
    // false : destination
    
    // MARK: Actions
    @IBAction func didChangeSegment(sender: AnyObject) {
        if let segment: UISegmentedControl! = sender as! UISegmentedControl {
            
            // post selected segment index
            NSNotificationCenter.defaultCenter().postNotificationName(
                WKSNotification.didSelectSegmentIndex.rawValue,
                object: segment.selectedSegmentIndex)
        }
    }
    
    @IBAction func didPushClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: alias
    typealias API = WKSFileController.FileAPI
    
    
    // MARK: View control
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        self.viewInit()
        self.setupNotification()
    }
    override func viewWillDisappear(animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: Notification
extension WKSAirportViewController {
    private func setupNotification() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateAirport:",
            name: WKSNotification.didSelectDeparture.rawValue,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateAirport:",
            name: WKSNotification.didSelectDestination.rawValue,
            object: nil)
    }
    
    // --- update label ---
    func updateAirport(notification: NSNotification?) {
        if let obj: API.AirportInfo! = notification?.object as? API.AirportInfo {
            self.airport = UILabel.customLabel(label: self.airport, text: obj!.Name)
            self.airportCode.text = obj!.Code + "/" + obj!.Country
            
            // --- fade-in animation ---
            UILabel.fadeInLabel(label: self.airport)
            UILabel.fadeInLabel(label: self.airportCode)
        }
    }
}

// MARK: Extension
extension WKSAirportViewController {
    func viewInit(){
        
        // --- collection view controller ---
        self.collectionViewController = WKSIndexCollectionViewController(tableView: self.tableView)
        
        self.collectionView.dataSource = self.collectionViewController
        self.collectionView.delegate = self.collectionViewController
        
        // --- table view controller ---
        self.tableViewController = WKSTableViewController()
        self.tableViewController.category = "airport"
        self.tableViewController.segueInfo = self.segueInfo
        
        self.tableView.dataSource = self.tableViewController
        self.tableView.delegate = self.tableViewController
    }
}

