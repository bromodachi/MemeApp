//
//  textFieldDelegate.swift
//  imagePickerPractice
//
//  Created by XcodeUser on 9/4/15.
//  Copyright (c) 2015 XcodeUser. All rights reserved.
//

import Foundation
import UIKit

class textFieldDelegate : NSObject, UITextFieldDelegate{
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 /*   func keyboardShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight()
        
    }
    
    func getKeyboardHeight(notification: NSNotification)->CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShow", name: UIKeyboardWillShowNotification, object: nil)
    }*/
    
}