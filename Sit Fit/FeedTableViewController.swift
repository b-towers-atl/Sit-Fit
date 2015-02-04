//
//  FeedTableViewController.swift
//  Sit Fit
//
//  Created by Bobby Towers on 2/3/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refreshFeed()
        // we can comment this out because viewWillAppear will run
        
    }
    
    func refreshFeed() {
        
        FeedData.mainData().refreshFeedItems { () -> () in
            
            // this is a time capsule, it is passed after the request finishes
            self.tableView.reloadData()
            
        }
    
    }
    
    // this isn't the best way because when you switch in between
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshFeed()
        
    }
    
    // viewWillAppear will rerun when pop and dismisses occur
//    override func viewWillAppear(animated: Bool) {
//        
//        FeedData.mainData().refreshFeedItems { () -> () in
//            
//            // this is a time capsule, it is passed after the request finishes
//            self.tableView.reloadData()
//            
//        }
//        
//    }
    
    @IBAction func addNewSeat(sender: AnyObject) {
    
        var newSeatSB = UIStoryboard(name: "NewSeat", bundle: nil)
        var newSeatVC = newSeatSB.instantiateInitialViewController() as NewSeatViewController
        
        presentViewController(newSeatVC, animated: true, completion: nil)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return FeedData.mainData().feedItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as UITableViewCell

        let seat = FeedData.mainData().feedItems[indexPath.row]
        
        cell.textLabel?.text = seat["name"] as? String
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
