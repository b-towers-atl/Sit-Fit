//
//  MapViewController.swift
//  Sit Fit
//
//  Created by Bobby Towers on 2/5/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func refreshFeed() {
        
        FeedData.mainData().refreshFeedItems { () -> () in
            
            // make annotations from feedItems
            self.createAnnotationsWithSeats(FeedData.mainData().feedItems)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshFeed()
    }
    
    func createAnnotationsWithSeats(seats: [PFObject]) {
        
        for seat in seats {
            
            let venue = seat["venue"] as [String:AnyObject]
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coord = CLLocationCoordinate2DMake(lat, lng)
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(coord)
            
            myMapView.addAnnotation(annotation)
            annotation.title = seat["name"] as String
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
