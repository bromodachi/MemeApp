//
//  MemesCollectionViewController.swift
//  imagePickerPractice
//
//  Created by XcodeUser on 9/8/15.
//  Copyright (c) 2015 XcodeUser. All rights reserved.
//

import UIKit

class MemesCollectionViewController : UICollectionViewController {
    
    //memeCell
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var memesCollection: UICollectionView!
    
    var memes : [Meme]{
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.memesCollection.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.memesCollection.reloadData()
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let space : CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CustomCellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! CustomCellCollection
        let meme = memes[indexPath.row]
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        cell.image.image = meme.memeImage
        return cell
    }
    
    
    /*var memes: [Meme]{
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }*/

}
