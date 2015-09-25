//
//  WKSInfoTableViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/23/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSInfoTableViewController: NSObject {
    // MARK: Properties
    // --- private ---
    
    // --- public ---
    var info: WKSInformation!
    
    // --- private ---
    private var tableView: UITableView!
    private var noticeLabel: UILabel!
    private var isChanged = false
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(info: WKSInformation, tableView: UITableView){
        super.init()
        
        self.info = info
        self.tableView = tableView
    }
    
    // MARK: Alias
    typealias Table = WKSInfoViewTableCell
    typealias Date = WKSInfoViewDateTableCell
    typealias Notice = WKSInfoViewNoticeTimeTableCell
    typealias Switch = WKSInfoViewNoticeSwitchTableCell
}

// MARK: TableView delegate and datasource
extension WKSInfoTableViewController: UITableViewDataSource, UITableViewDelegate {
    // --- dataSource ---
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    // --- delegate ---
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // cell configuration
        switch indexPath.row {
        case 0:
            // --- Date Cell --
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(Table.DateCell.rawValue)!
            
            let dateLabel = cell.viewWithTag(Date.Date.rawValue) as! UILabel
            let timeLabel = cell.viewWithTag(Date.Time.rawValue) as! UILabel
            
            
            dateLabel.text = self.info.dateStr
            timeLabel.text = self.info.timeStr
            
            
            //dateLabel.text = "test Date"
            //timeLabel.text = "test Time"
            
            
            return cell
            
        case 1:
            // --- Notice time cell ---
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(Table.NoticeTimeCell.rawValue)!
                        
            let notice = cell.viewWithTag(Notice.Time.rawValue) as! UILabel
            notice.text = String(self.info.alermTime)
            
            // buffering
            self.noticeLabel = notice

            
            let stepper = cell.viewWithTag(Notice.Stepper.rawValue) as! UIStepper
            stepper.value = Double(self.info.alermTime)
            stepper.minimumValue = 0.0
            stepper.maximumValue = 60.0
            stepper.stepValue = 1
        
            stepper.addTarget(self, action: "didChangeValue:", forControlEvents: .ValueChanged)
            
            return cell
            
        case 2:
            // --- Notice switch cell ---
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(Table.NoticeSwitchCell.rawValue)!
            
            let sw = cell.viewWithTag(Switch.Switch.rawValue) as! UISwitch
            sw.on = self.info.alerm
            
            sw.addTarget(self, action: "didChangeStatus:", forControlEvents: .ValueChanged)
            
            return cell
        default:
            // --- Date Cell --
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(Table.DateCell.rawValue)!
            
            let dateLabel = cell.viewWithTag(Date.Date.rawValue) as! UILabel
            let timeLabel = cell.viewWithTag(Date.Time.rawValue) as! UILabel
            
            dateLabel.text = self.info.dateStr
            timeLabel.text = self.info.timeStr
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 70.0
        case 1:
            return 60.0
        default:
            return 44.0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Information of Notification"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func didChangeValue(sender: AnyObject?) {
        if let obj: UIStepper! = sender as? UIStepper {
            self.info.alermTime = Int(obj!.value)
            self.noticeLabel.text = String(self.info.alermTime)
        }
        
        // set change flag
        self.isChanged = true
        
        // post updated infomation object
        self.updateInfomation(self.info)
    }
    
    func didChangeStatus(sender: AnyObject?) {
        if let obj: UISwitch! = sender as? UISwitch {
            if obj!.on {
                self.info.alerm = true
            } else {
                self.info.alerm = false
            }
        }
        
        // set change flag
        self.isChanged = true
        
        // post updated infomation object
        self.updateInfomation(self.info)
    }
    
    private func updateInfomation(infoObj: WKSInformation) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            WKSNotification.didUpdateInfo.rawValue,
            object: infoObj)
    }
}
