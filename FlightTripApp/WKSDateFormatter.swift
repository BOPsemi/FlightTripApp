//
//  WKSDateFormatter.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/23/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation

extension NSDateFormatter {
    class func customDateFormatter(format format: String) -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }
}
