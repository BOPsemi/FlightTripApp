//
//  ViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/13/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    private var infos = [WKSInformation]()
    private var tableViewController: WKSTopTableViewController!
    
    // MARK: Outlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLifeMilage: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    // --- Ranking stars ---
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    // --- table view for displaying detail ---
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Actions
    @IBAction func didPushUserAdd(sender: AnyObject) {
    }
    

    // MARK: View control
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        self.initView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: Methods
extension ViewController {
    private func initView() {
        
        // test
        let info = self.setupTestObject()
        self.infos.append(info)
        // test
        
        self.tableViewController = WKSTopTableViewController(infos: self.infos)
        self.tableView.dataSource = self.tableViewController
        self.tableView.delegate = self.tableViewController
    }
}

// MARK: Test Object
extension ViewController {
    private func setupTestObject() -> WKSInformation {
        let info = WKSInformation()
        
        let airline = WKSFileController.FileAPI.AirlineInfo()
        airline.Name = "Test Airline"
        
        let departure = WKSFileController.FileAPI.AirportInfo()
        departure.Name = "Test Departure"
        
        let destination = WKSFileController.FileAPI.AirportInfo()
        destination.Name = "Test Destination"
        
        info.airline = airline
        info.departure = departure
        info.destination = destination
        info.dateStr = "Test-Date,Test-Time"
        
        return info
    }
}
