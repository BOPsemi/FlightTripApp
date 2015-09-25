//
//  WKSDatePickerViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/23/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSDatePickerViewController: UIView {
    // MARK: Properties
    // --- private ---
    private var datePicker: UIDatePicker!
    private var toolbar: UIToolbar!
    private var screenSize: CGSize!
    private var pickDate: String!
    
    private var dateFormatter: NSDateFormatter!

    // --- public ---
    var backColor: UIColor = UIColor.whiteColor()
    
    
    // MARK: Initializer
    init(){
        super.init(frame: CGRectZero)
        self.initView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
}

// MARK: actions
extension WKSDatePickerViewController {
    // show picker
    func showPicker() {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.frame = CGRectMake(0, self.screenSize.height - 260.0 , self.screenSize.width, 260.0)
        }
    }
    
    // hide picker when the cancel is pushed
    func didPushCancel() {
        self.hidePicker()
    }
    
    func didPushSet() {
        self.hidePicker()
        NSNotificationCenter.defaultCenter().postNotificationName(
            WKSNotification.didPickDate.rawValue,
            object: self.pickDate)
    }
    
    private func hidePicker(){
        UIView.animateWithDuration(0.2) { () -> Void in
            self.frame = CGRectMake(0, self.screenSize.height, self.screenSize.width, 260.0)
        }
    }
    
    // --- date pick ---
    func didPickDate(sender: UIDatePicker) {
        self.pickDate = self.dateFormatter.stringFromDate(sender.date)
        
    }
}

// MARK: initialize View
extension WKSDatePickerViewController {
    // MARK: Methods
    private func initView(){
        
        // --- screen ---
        self.screenSize = UIScreen.mainScreen().bounds.size
        self.bounds = CGRectMake(0, 0, screenSize.width, 260)
        self.frame = CGRectMake(0, screenSize.height, screenSize.width, 260)
        
        // --- date picker ---
        self.datePicker = UIDatePicker()
        self.datePicker.bounds = CGRectMake(0, 0, screenSize.width, 216)
        self.datePicker.frame = CGRectMake(0, 44, screenSize.width, 216)
        self.datePicker.backgroundColor = self.backColor

        self.datePicker.locale = NSLocale.currentLocale()
        
        // --- tool bar ---
        self.toolbar = UIToolbar()
        self.toolbar.translucent = true
        self.toolbar.bounds = CGRectMake(0, 0, screenSize.width, 44)
        self.toolbar.frame = CGRectMake(0, 0, screenSize.width, 44)
        self.toolbar.setItems(setupToolbar(), animated: true)
        
        // --- add subView ---
        self.addSubview(toolbar)
        self.addSubview(datePicker)
        
        // --- event handler ---
        self.datePicker.addTarget(
            self,
            action: "didPickDate:",
            forControlEvents: .ValueChanged)
        
        // --- setup date formatter ---
        
        self.dateFormatter = NSDateFormatter.customDateFormatter(format: "yyyy-MM-dd,HH:mm")
        self.pickDate = self.dateFormatter.stringFromDate(NSDate())
    }
    
    // --- setup toolbar ---
    private func setupToolbar() -> [UIBarButtonItem] {
        let fixspace = UIBarButtonItem(
            barButtonSystemItem: .FixedSpace,
            target: nil,
            action: nil)
        let flexspace = UIBarButtonItem(
            barButtonSystemItem: .FlexibleSpace,
            target: nil,
            action: nil)
        let cancel = UIBarButtonItem(
            barButtonSystemItem: .Stop,
            target: self,
            action: "didPushCancel")
        let set = UIBarButtonItem(
            title: "SET",
            style: .Done,
            target: self,
            action: "didPushSet")
        
        fixspace.width = 12
        
        let toolbarItems = [fixspace,set,flexspace,cancel,fixspace]
        
        return toolbarItems
    }
}
