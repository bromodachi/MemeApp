//
//  ViewFullMemeController.swift
//  imagePickerPractice
//
//  Created by XcodeUser on 9/9/15.
//  Copyright (c) 2015 XcodeUser. All rights reserved.
//

import UIKit

class ViewFullMemeController: UIViewController {
    
    @IBOutlet weak var fullImage: UIImageView!
    
    var image : UIImage!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.fullImage.image = image
    }
    
}
