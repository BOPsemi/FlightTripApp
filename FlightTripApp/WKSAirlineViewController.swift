//
//  WKSAirlineViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/21/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSAirlineViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var airline: UILabel!
    @IBOutlet weak var airlineCode: UILabel!
    
    
    // Properties
    private var collectionViewController: WKSIndexCollectionViewController!
    private var tableViewController: WKSTableViewController!
    
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
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    // MARK: alias
    typealias API = WKSFileController.FileAPI
    
    
    // MARK: View Control
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        self.viewInit()
        self.setupNotification()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK: Notification
extension WKSAirlineViewController {
    private func setupNotification(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateAirline:",
            name: WKSNotification.didSelectAirline.rawValue,
            object: nil)
    }
    
    func updateAirline(notification: NSNotification?) {
        if let obj: API.AirlineInfo! = notification?.object as? API.AirlineInfo {
            self.airline = UILabel.customLabel(label: self.airline, text: obj!.Name)
            self.airlineCode.text = obj!.Code + "/" + obj!.TwoWordCode
            
            // --- animation ---
            UILabel.fadeInLabel(label: self.airline)
            UILabel.fadeInLabel(label: self.airlineCode)
        }
    }
}

// MARK: Extension 
extension WKSAirlineViewController {
    func viewInit(){
        
        // --- collection view controller ---
        self.collectionViewController = WKSIndexCollectionViewController(tableView: self.tableView)
        
        self.collectionView.dataSource = self.collectionViewController
        self.collectionView.delegate = self.collectionViewController
        
        // --- table view controller ---
        self.tableViewController = WKSTableViewController()
        
        self.tableView.dataSource = self.tableViewController
        self.tableView.delegate = self.tableViewController
    }
}
