//
//  NewSeatViewController.swift
//  Sit Fit
//
//  Created by Bobby Towers on 2/3/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class NewSeatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    @IBOutlet weak var seatImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NewSeatVC becomes the delegate of the imagePicker
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        // NewSeatVC becomes the delegate of the text field
        seatNameField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.seatImageView.image = image
        
        // if we implement the picker view, WE need to dismiss it manually
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func resizeImage(image: UIImage, withSize size:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
        // we've done something similar in Obj-C with our Capture app
        
//        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return newImage;
        
    }
    
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
//        newSeat["creator"] = PFUser.currentUser()
        
        // change the file sizes
        let image = resizeImage(seatImageView.image!, withSize: CGSizeMake(540, 540))
        
        // need to pass an image in its raw format (data) to a database
        // turn UIImage into PFFile and add to newseat
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name: "seat.png", data: imageData)
        newSeat["image"] = imageFile
        newSeat.saveInBackground()
        
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
