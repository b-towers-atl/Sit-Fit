//
//  FeedData.swift
//  Sit Fit
//
//  Created by Bobby Towers on 2/3/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

let _mainData: FeedData = FeedData()

class FeedData: NSObject {
    
    var selectedVenue: [String:AnyObject]?
    
    var feedItems: [PFObject] = []
//    var myFeedItems: [PFObject] = []
    
    class func mainData() -> FeedData {
        
        return _mainData
        
    }
    
    // first custom completion block parameter
    // closure type is indicated by () -> ()
    // functions are actually just special cases of closures: parameters on the left, return on the right
    // but this block has no paramaters, and no return, just a chunk of code to be ran later in time
    func refreshFeedItems(completion: () -> () ) {
        
        var feedQuery = PFQuery(className: "Seat")
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.feedItems = objects as [PFObject]
                
            }
            
            completion()
            
        }
        
    }
    
    func refreshMyFeedItems(completion: () -> () ) {
        
        var feedQuery = PFQuery(className: "Seat")
        
        // key refers to a column, value of creator is equal to something
        feedQuery.whereKey("creator", equalTo: PFUser.currentUser())
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            // comment out the conditional because if you do not create anything, it won't refresh
            //            if objects.count > 0 {
            
            self.feedItems = objects as [PFObject]
            
            //            }
            
            completion()
            
        }
        
    }
   
}
