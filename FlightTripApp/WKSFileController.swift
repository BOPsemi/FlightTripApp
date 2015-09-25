//
//  WKSFileController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/21/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation


class WKSFileController: NSObject {
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    
    class FileAPI: WKSFileController {
        
        // --- Airline information class ---
        class AirlineInfo {
            var TwoWordCode: String = ""
            var Code: String = ""
            var Name: String = ""
        }
        
        // --- Airport information class ---
        class AirportInfo {
            var Name: String = ""
            var Country: String = ""
            var Code: String = ""
        }
        
        // --- buffer structure ---
        private struct FileContents {
            var item1: String
            var item2: String
            var item3: String
        }
        
        // MARK: Initializer
        // --- default init ---
        override init() {
            super.init()
        }
        
        // MARK: Methods
        // --- read CSV file ---        
        func readCSVFile() -> (airports: [AirportInfo], airlines: [AirlineInfo]){
            
            let airportFileName = "airport"
            let airlineFileName = "airline"
            
            let airportList = open(fileName: airportFileName)
            let airlineList = open(fileName: airlineFileName)
            
            let airports = mapping(classType: AirportInfo(), contents: airportList)
            let airlines = mapping(classType: AirlineInfo(), contents: airlineList)
            
            return (airports, airlines)
            
        }
        
        // --- object mapping ---
        private func mapping<ClassType>(classType classType:ClassType, contents: [FileContents]) -> [ClassType] {
            var objs = [ClassType]()
            
            // --- Airport Class ---
            if classType is AirportInfo {
                for obj in contents {
                    
                    let airport = AirportInfo()
                    airport.Name = obj.item1
                    airport.Country = obj.item2
                    airport.Code = obj.item3
                    
                    // append object to stack array
                    objs.append(airport as! ClassType)
                }
            }
            
            // --- Airline Class ---
            if classType is AirlineInfo {
                for obj in contents {
                    
                    let airline = AirlineInfo()
                    airline.TwoWordCode = obj.item1
                    airline.Code = obj.item2
                    airline.Name = obj.item3
                    
                    // append object to stack array
                    objs.append(airline as! ClassType)
                }
            }
            
            // return
            return objs
        }
        
        // --- open csv file ---
        private func open(fileName fileName:String) -> [FileContents] {
            var objs = [FileContents]()
            
            if let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv") {
                if let content = try? String(contentsOfFile: filePath) {
                    content.enumerateLines({ (line: String, stop) -> () in
                        let items = line.componentsSeparatedByString(",")
                        let obj = FileContents(item1: items[0], item2: items[1], item3: items[2])
                        
                        objs.append(obj)
                    })
                }
            }
            
            return objs
        }
        
        // --- file filter ---
        class func filter<ClassType>(keyindex keyindex: Int, keyword: String, resource: [ClassType]) -> [ClassType] {
            // keyindex : string from segment
            // keyword : alphabet
            // resource : AirportInfo or AirlineInfo
            
            let object = resource[0]
            var stack = [ClassType]()
            
            // --- Airport Info class ---
            if object is WKSFileController.FileAPI.AirportInfo {
                for obj in resource {
                    
                    let item = obj as! WKSFileController.FileAPI.AirportInfo
                    switch keyindex {
                    case 1:
                        if item.Code.hasPrefix(keyword) {
                            stack.append(item as! ClassType)
                        }
                    case 2:
                        if item.Country.hasPrefix(keyword) {
                            stack.append(item as! ClassType)
                        }
                    default:
                        if item.Name.hasPrefix(keyword) {
                            stack.append(item as! ClassType)
                        }
                    } // switch
                } // for loop
            } // airport
            
            // --- Airline Info class ---
            if object is WKSFileController.FileAPI.AirlineInfo {
                for obj in resource {
                    
                    let item = obj as! WKSFileController.FileAPI.AirlineInfo
                    switch keyindex {
                    case 1:
                        if item.Code.hasPrefix(keyword) {
                            stack.append(item as! ClassType)
                        }
                    case 2:
                        if item.Name.hasPrefix(keyword) {
                            stack.append(item as! ClassType)
                        }
                    default:
                        if item.TwoWordCode.hasPrefix(keyword) {
                            stack.append(item as! ClassType)
                        }
                    } // switch
                } // for loop
            } // airline
            
            return stack
        }
    }
}
