//
//  Meme.swift
//  imagePickerPractice
//
//  Created by XcodeUser on 9/4/15.
//  Copyright (c) 2015 XcodeUser. All rights reserved.
//

import Foundation
import UIKit


class Meme {
    var topText: String!
    var bottomText : String!
    var originalImage : UIImage!
    var memeImage: UIImage!
    
    init (topText:String, bottomText:String, orgImage: UIImage, memeImage:UIImage ){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = orgImage
        self.memeImage = memeImage
    }
    
}