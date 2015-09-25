//
//  WKSTransaction.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/24/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSTransaction: NSObject {
    // MARK: Properties
    private var info: WKSInformation!
    
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(info: WKSInformation){
        super.init()
        self.info = info
    }
    
    // MARK: Class
    
    class Strage: WKSTransaction {
        // MARK: Initilizer
        override init() {
            super.init()
        }
        
        // MARK: Methods
        // --- save ---
        class func saveObject() {
            
        }
        
        // --- locad ---
        class func loadObject() {
            
        }
    }
    
    
    
}
