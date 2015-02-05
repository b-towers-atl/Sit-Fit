//
//  FourSquareRequest.swift
//  Maps
//
//  Created by Bobby Towers on 2/2/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import CoreLocation
// frameworks you need to import in each file as needed

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "KVTPSBZTOVR0ZE0C0O22FSYDF1IFBKNY5W0DFPAVJVG1PZWR"
let CLIENT_SECRET = "AUBIR3KMQWIPZFH4GOBRHMYJTX3HUOPPM15BFS5TEYQGXPU2"


class FourSquareRequest: NSObject {
    
    class func requestVenuesWithLocation(location: CLLocation) -> [AnyObject] {
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        println(requestString)
        
        // when we create an if statement with an optional, we do not have to force unwrap it, but just check if it is there by a conditional
        // this makes it much safer, just a fail safe conditional
        if let url = NSURL(string: requestString) {
            
            let request = NSURLRequest(URL: url)
            
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    
                    let venues = responseInfo["venues"] as [AnyObject]
                    
                    return venues
                    
                }
                
            }
            
        }
        
        //TODO: add implmentation to return venues
        
        return []
        
    }
   
}









