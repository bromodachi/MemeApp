//
//  ViewController.swift
//  imagePickerPractice
//
//  Created by XcodeUser on 9/3/15.
//  Copyright (c) 2015 XcodeUser. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pickerToolbar: UIToolbar!
    //create delegates
    let textDelegate = textFieldDelegate()
    
    //create attributes 
    
    let textAttribute = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:40)!,
        NSStrokeWidthAttributeName: -1.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        
        //disable share button until image has been chosen
        self.saveButton.enabled = false

        //top textfield
        self.topTextfield.text = "TOP"
        self.topTextfield.textAlignment = .Center
        self.topTextfield.delegate =  textDelegate
        self.topTextfield.defaultTextAttributes = textAttribute
        
        //bottom
        self.bottomTextfield.text = "BOTTOM"
        self.bottomTextfield.textAlignment = .Center
        self.bottomTextfield.delegate = textDelegate
        self.bottomTextfield.defaultTextAttributes = textAttribute
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func  imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
            imagePickerView.autoresizingMask = (UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin |
                UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin|UIViewAutoresizing.FlexibleWidth)
            dismissViewControllerAnimated(true, completion: nil)
            saveButton.enabled = true
        }
    }
    
    func save () {
        //init (topText:String, bottomText:String, orgImage: UIImage, memeImage:UIImage )
            let meme = Meme (topText: topTextfield.text, bottomText: bottomTextfield.text, orgImage:imagePickerView.image!, memeImage: generateMemeImage())
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        println(appDelegate.memes.count)
        
    }
    
    func generateMemeImage() ->UIImage{
        
        pickerToolbar.hidden = true
        self.navigationController?.navigationBarHidden = true

        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        pickerToolbar.hidden = false
        self.navigationController?.navigationBarHidden = false

        
        return memedImage
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotification()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotification()
    }

    
    
    //picking an image from the camera or album
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }

    @IBAction func pickAnImageCamera(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memeImage = generateMemeImage()
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, activityError) in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
                
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            
        
        }
        self.presentViewController(activityController, animated: true, completion: nil)
        
        
    }
    
    
    //keyboards/ text related methods
    
    func keyboardShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        
    }
    
    func keyboardHide(notification: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notification)
        
    }
    
    func getKeyboardHeight(notification: NSNotification)->CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self,  name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

