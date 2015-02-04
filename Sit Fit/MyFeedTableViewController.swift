//
//  MyFeedTableViewController.swift
//  Sit Fit
//
//  Created by Bobby Towers on 2/3/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class MyFeedTableViewController: FeedTableViewController {

    override func refreshFeed() {
        
        FeedData.mainData().refreshMyFeedItems { () -> () in
            
            // this is a time capsule, it is passed after the request finishes
            self.tableView.reloadData()
            
        }
        
    }
    
}
