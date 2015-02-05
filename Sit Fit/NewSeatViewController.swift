//
//  NewSeatViewController.swift
//  Sit Fit
//
//  Created by Bobby Towers on 2/3/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

/*

homework :
+ commit todays work on your master branch
+ create new branch name homework-w5d3
+1. when you hit save on a new seat, create a PFFile using the UIImage on the seatImageView
+2. make the tableviewcell height 200
+3. add a uiimageview to the prototype cell on the storyboard
+4. create a custom class for the uitableviewcell named FeedCell
+5. add an iboutlet to the class for the uiimageview
-6. set the image for the imageview based on the PFFile from the Seat PFObject

*/

import UIKit

class NewSeatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // var seats: [PFObject]?
    
    // 1.
    var image: UIImage?
    
    @IBOutlet weak var seatNameField: UITextField!
    
    @IBOutlet weak var seatImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func takePicture(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.seatImageView.image = image
        
        // if we implement the picker view, WE need to dismiss it manually
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat["creator"] = PFUser.currentUser()
        // #1
        newSeat.saveInBackground()
        
        // 1.
        // create PFFile for image
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"image.png", data:imageData)
        
        var seatPhoto = PFObject(className:"UserPhoto")
        seatPhoto["imageName"] = "Seat Photo"
        seatPhoto["imageFile"] = imageFile
        seatPhoto.saveInBackground()
        // end 1.
        
        FeedData.mainData().feedItems.append(newSeat)
    
        dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func cancelSeat(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
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
