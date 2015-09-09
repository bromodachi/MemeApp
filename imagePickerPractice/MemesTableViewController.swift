//
//  MemesTableViewController.swift
//  imagePickerPractice
//
//  Created by XcodeUser on 9/8/15.
//  Copyright (c) 2015 XcodeUser. All rights reserved.
//

import UIKit

class MemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memeTable: UITableView!
    var memes : [Meme]{
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "createMeme")
        
        self.memeTable.reloadData()
        
        self.tabBarController?.tabBar.hidden = false
        
        
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
       
        
        
    }
    
    func createMeme(){
        let storyboard = self.storyboard
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("createMeme") as! ViewController
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTable") as! UITableViewCell
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.imageView?.image = meme.memeImage
        println(memes.count)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
