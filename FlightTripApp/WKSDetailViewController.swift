//
//  WKSDetailViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/21/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSDetailViewController: UIViewController {
    
    // MARK: Properties
    private var info: WKSInformation!
    private var tableViewController: WKSDetailTableViewController!
    
    // MARK: Outlets
    @IBOutlet weak var airline: UILabel!
    @IBOutlet weak var sw: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    

    // MARK: Actions
    @IBAction func didPushClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            // TODO: write object update
        }
    }
    
    @IBAction func didPushReload(sender: AnyObject) {
            // TODO: write weather reload
    }
    
    @IBAction func didPushTrash(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            // TODO: write delete object transaction
        }
    }
    
    // MARK: View Control
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNotification()
    }
    override func viewWillAppear(animated: Bool) {
        self.initView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: Methods
extension WKSDetailViewController {
    private func initView() {
        self.tableViewController = WKSDetailTableViewController(info: self.info)
        
        self.tableView.dataSource = self.tableViewController
        self.tableView.delegate = self.tableViewController
        
        self.sw.on = self.info.alerm
        self.airline.text = self.info.airline.Name
    }
}

// MARK: setup notification
extension WKSDetailViewController {
    private func setupNotification(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "loadSelectInfo:",
            name: WKSNotification.didSelectInfo.rawValue,
            object: nil)
    }
    
    func loadSelectInfo(notification: NSNotification?) {
        if let info: WKSInformation! = notification?.object as? WKSInformation {
            self.info = info!
        }
    }
}
