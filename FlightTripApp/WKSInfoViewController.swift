//
//  WKSInfoViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/21/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSInfoViewController: UIViewController {

    // MARK: Actions
    @IBAction func didPushCalender(sender: AnyObject) {
        self.datePickerViewController = WKSDatePickerViewController()
        if let window = UIApplication.sharedApplication().keyWindow {
            window.addSubview(self.datePickerViewController)
        } else {
            self.view.addSubview(self.datePickerViewController)
        }
        
        self.datePickerViewController.showPicker()
    }
    
    @IBAction func didPushSave(sender: AnyObject) {
        print(self.info.alermTime)
        print(self.info.alerm)
    }
    
    
    // MARK: Outlets
    @IBOutlet weak var airline: UILabel!
    @IBOutlet weak var departure: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var departureDateTime: UILabel!
    
    @IBOutlet weak var airlineCode: UILabel!
    @IBOutlet weak var departureCode: UILabel!
    @IBOutlet weak var destinationCode: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var datePickerViewController: WKSDatePickerViewController!
    private var tableViewController: WKSInfoTableViewController!
    private var info: WKSInformation!
    
    // MARK: View Control
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        self.setupNotification()
        self.initView()
        
        // --- initialize infomation class ---
        if self.info == nil {
            self.info = WKSInformation()
        }
        
    }
    override func viewDidDisappear(animated: Bool) {
        
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "departureSegue" {
            let airportViewController = segue.destinationViewController as! WKSAirportViewController
            
            // switch segue information
            airportViewController.segueInfo = true
        }
        if segue.identifier == "destinationSegue" {
            let airportViewController = segue.destinationViewController as! WKSAirportViewController
            
            // switch segue information
            airportViewController.segueInfo = false
        }
    }
}

// MARK: Methods
extension WKSInfoViewController {
    // --- initialize view ---
    private func initView(){
        self.tableView.hidden = true
    }
}


// MARK: Notification
extension WKSInfoViewController {
    // ---- setup notification ---
    private func setupNotification(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateAirline:",
            name: WKSNotification.didSelectAirline.rawValue,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateDeparture:",
            name: WKSNotification.didSelectDeparture.rawValue,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateDestination:",
            name: WKSNotification.didSelectDestination.rawValue,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateDate:",
            name: WKSNotification.didPickDate.rawValue,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateInfo:",
            name: WKSNotification.didUpdateInfo.rawValue,
            object: nil)
    }
    
    func updateAirline(notification: NSNotification?){
        if let obj: WKSFileController.FileAPI.AirlineInfo!
            = notification?.object as? WKSFileController.FileAPI.AirlineInfo {
            
            // update label
            self.airline = UILabel.customLabel(label: self.airline, text: obj!.Name)
            self.airlineCode.text =   obj!.Code + "/" + obj!.TwoWordCode
                
            // set state flag
            self.info.isSetAirline = true
                
            // update value
            self.info.airline = obj     // airline class
        }
    }
    
    func updateDeparture(notification: NSNotification?) {
        if let obj: WKSFileController.FileAPI.AirportInfo!
            = notification?.object as? WKSFileController.FileAPI.AirportInfo {
                
            // update label
            self.departure = UILabel.customLabel(label: self.departure, text: obj!.Name)
            self.departureCode.text = obj!.Code + "/" + obj!.Country
                
            // set state flag
            self.info.isSetDeparture = true
                
            // update value
            self.info.departure = obj   // departure airport
        }
    }
    
    func updateDestination(notification: NSNotification?) {
        if let obj: WKSFileController.FileAPI.AirportInfo!
            = notification?.object as? WKSFileController.FileAPI.AirportInfo {
        
            // update label
            self.destination = UILabel.customLabel(label: self.destination, text: obj!.Name)
            self.destinationCode.text = obj!.Code + "/" + obj!.Country
                
            // set state flag
            self.info.isSetDestination = true
                
            // update value
            self.info.destination = obj // destination airport
        }
    }
    
    func updateDate(notification: NSNotification?) {
        if let date: String! = notification?.object as? String {
            
            // set state flag
            self.info.isSetDate = true
            
            // update value
            self.info.date = date!
            
            // --- setup tableView ---
            self.tableView.hidden = false
            self.tableViewController = WKSInfoTableViewController(info: self.info, tableView: self.tableView)
            
            self.tableView.dataSource = self.tableViewController
            self.tableView.delegate = self.tableViewController
            
            self.tableView.reloadData()
            
        }
    }
    
    func updateInfo(notification: NSNotification?) {
        if let obj: WKSInformation! = notification?.object as? WKSInformation {
            self.info = obj!
        }
    }
    
    
}
