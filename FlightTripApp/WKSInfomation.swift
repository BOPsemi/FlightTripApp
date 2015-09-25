//
//  WKSInfomation.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/23/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation

class WKSInformation: NSObject {
    
    // MARK: Alias
    typealias Airport = WKSFileController.FileAPI.AirportInfo
    typealias Airline = WKSFileController.FileAPI.AirlineInfo
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    
    // MARK: Properties
    // --- airline and ariport information ---
    var airline: Airline!
    var departure: Airport!
    var destination: Airport!
    
    // --- alerm information ---
    var alermTime: Int = 10
    var alerm: Bool = false
    
    // --- date and time information ---
    var dateStr: String!
    var timeStr: String!
    var date: String! {
        didSet{
            let dateStrs = self.separateDateString()
            self.dateStr = dateStrs.date
            self.timeStr = dateStrs.time
        }
    }
    
    // --- flags ---
    var isSetAirline = false
    var isSetDeparture = false
    var isSetDestination = false
    var isSetDate = false
    
}

// MARK: Methods
extension WKSInformation {
    
    func isReadyForTransaction() -> Bool {
        var status = false
        
        if self.isSetAirline {
            if self.isSetDeparture {
                if self.isSetDestination {
                    status = true
                }
            }
        }
        
        return status
    }
    
    // --- separate date string ---
    private func separateDateString() -> (date: String, time: String) {
        let objs = self.date.componentsSeparatedByString(",")
        
        let dateStr = objs[0]
        let timeStr = objs[1]
        
        return (dateStr, timeStr)
    }
}
