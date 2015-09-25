//
//  WKSIndexCollectionViewController.swift
//  FlightTripApp
//
//  Created by Kazufumi Watanabe on 9/21/15.
//  Copyright © 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

// MARK: Class definition
class WKSIndexCollectionViewController: NSObject {
    
    // MARK: Properties
    private var tableView: UITableView!
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(tableView:UITableView){
        super.init()
        self.tableView = tableView
    }
}


// MARK: delegate and dataSource
extension WKSIndexCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // --- datadource ---
    func collectionView(
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        return kAlphabet.count
    }
    
    // --- delegate ---
    func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
        // --- cell configuration ---
        let cellName = "indexCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellName,
            forIndexPath: indexPath)
        
        // --- label setup ---
        let cellIndexLabel = cell.viewWithTag(101) as! UILabel
        cellIndexLabel.text = kAlphabet[indexPath.row]
        
        // return
        return cell
    }
    
    func collectionView(
        collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // post keyword to notification center            
        NSNotificationCenter.defaultCenter().postNotificationName(
            WKSNotification.didSelectKeyword.rawValue,
            object: kAlphabet[indexPath.row])
            
        tableView.reloadData()
    }
    
    // MARK: Cell view control
    
}
