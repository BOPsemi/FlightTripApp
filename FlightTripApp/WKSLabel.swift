//
//  WKSLabel.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/23/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

extension UILabel {
    // MARK: custom label
    class func customLabel(label label: UILabel, text: String) -> UILabel {
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.hexStr("#0099CC", alpha: 1)
        label.text = text
        
        return label
    }
    
    // MARK: label fade-in
    class func fadeInLabel(label label: UILabel) {
        label.alpha = 0.0
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: .CurveEaseIn,
            animations: { () -> Void in
                label.alpha = 1.0
            },
            completion: nil)
    }
}
