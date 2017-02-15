//
//  DetailsViewController.swift
//  AlbumApp
//
//  Created by adarvish on 15/02/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView?;
    @IBOutlet weak var imageView: UIImageView?;
    @IBOutlet weak var actInd: UIActivityIndicatorView?;
    
    var aPhotos = [AlbumPhotoModel]();
    var service: PhotoAlbumService? = nil;

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Album Details";
        
        service = PhotoAlbumService();
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        let indexPathForFirstRow = IndexPath.init(row: 0, section: 0);
        self.collectionView?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0));
        self.collectionView(self.collectionView!, didSelectItemAt: indexPathForFirstRow);
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //CollectionView Delegate/DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.aPhotos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell: ThumbCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! ThumbCell;
        
        let aPhoto = self.aPhotos[indexPath.row];
        
        let image = SimpleSharedCache.sharedInstance.getCacheObject(key: "thum\(aPhoto.id)" as NSString);
        if(image == nil)
        {
            service?.GetDataFromUrl(url: aPhoto.thumbnailUrl!, successBlock: { (image) in
                cell.imageView?.image = image;
                cell.actInd?.stopAnimating();
                SimpleSharedCache.sharedInstance.setCacheObject(object: image, key: "thum\(aPhoto.id)" as NSString)
            });
        }
        else
        {
            cell.actInd?.stopAnimating();
            cell.imageView?.image = image;
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let aPhoto = self.aPhotos[indexPath.row];
        
        let image = SimpleSharedCache.sharedInstance.getCacheObject(key: "photo\(aPhoto.id)" as NSString);
        if(image == nil)
        {
            self.actInd?.startAnimating();
            service?.GetDataFromUrl(url: aPhoto.url!, successBlock: { (image) in
                self.actInd?.stopAnimating();
                self.imageView?.image = image;
                SimpleSharedCache.sharedInstance.setCacheObject(object: image, key: "photo\(aPhoto.id)" as NSString)
            });
        }
        else
        {
            self.imageView?.image = image;
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
