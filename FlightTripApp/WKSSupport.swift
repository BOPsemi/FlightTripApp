//
//  WKSSupport.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/18/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

// MARK: Alphabet array
// --- array for index search ---
let kAlphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
let kAirlineSegment = ["Name","Code","2Digit"]
let kAirportSegment = ["Name","Code","Country"]


// MARK: Notification Index
enum WKSNotification: String {
    case didSelectKeyword = "didSelectKeyword"
    case didSelectSegmentIndex = "didSelectSegmentIndex"
    
    case didSelectAirline = "didSelectAirline"
    case didSelectDeparture = "didSelectDeparture"
    case didSelectDestination = "didSelectDestination"
    
    case didPickDate = "didPickDate"
    
    case didUpdateInfo = "didUpdateInfo"
    
    case didSelectInfo = "didSelectInfo"
}

// MARK: Airport and Airline List
var kAirlines = [WKSFileController.FileAPI.AirlineInfo()]
var kAirports = [WKSFileController.FileAPI.AirportInfo()]

// MARK: TableView Cell Identifier for TopView
enum WKSTopViewTableCell: Int {
    case Airline = 101
    case Departure
    case Destination
    case Calender
}

// MARK: TableView Cell Identifier for InfoView
enum WKSInfoViewTableCell: String {
    case DateCell = "DateCell"
    case NoticeTimeCell = "NoticeTimeCell"
    case NoticeSwitchCell = "NoticeSwitchCell"
}
// --- DateCell
enum WKSInfoViewDateTableCell: Int {
    case Date = 101
    case Time
}

// MARK: TableView Cell Identifier for InfoView
// --- NoticeTimeCell
enum WKSInfoViewNoticeTimeTableCell: Int {
    case Time = 101
    case Stepper = 102
}

// MARK: TableView Cell Identifier for InfoView
// --- NoticeSwitchCell
enum WKSInfoViewNoticeSwitchTableCell: Int {
    case Switch = 101
}

// MARK: TableView Cell Identifier for DetailView
// --- DepCell
enum WKSDetailViewDepTableCell: Int {
    case Weather = 101
    case Depature = 102
    case Map = 103
}

// MARK: TableView Cell Identifier for DetailView
// --- DesCell
enum WKSDetailViewDesTableCell: Int {
    case Weather = 101
    case Destination = 102
    case Map = 103
}

// MARK: Collection Cell Identifier for Dep/Des Select
// --- Cell
enum WKSAirportViewTableCell: Int {
    case IndexCell = 101
}
enum WKSAirportViewCollectionCell: Int {
    case Alphabet = 101
}

// MARK: Collection Cell Identifier for Dep/Des Select
// --- Cell

enum WKSAirlineViewTableCell: Int {
    case Name = 101
    case Code = 102
}
enum WKSAirlineViewCollectionCell: Int {
    case Alphabet = 101
}