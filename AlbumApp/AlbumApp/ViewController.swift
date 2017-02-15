//
//  ViewController.swift
//  AlbumApp
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIBarPositioningDelegate
{
    @IBOutlet weak var tableView: UITableView?;
    var actInd: UIActivityIndicatorView?;
    
    
    var albums: [AlbumModel] = [];
    var pageNum = 1;

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Albums";
        
        tableView?.estimatedRowHeight = 100.0; // put max you expect here.
        tableView?.rowHeight = UITableViewAutomaticDimension;
        
        actInd = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge);
        actInd?.hidesWhenStopped = true;
        actInd?.color = UIColor.gray;
        
        let barBtn = UIBarButtonItem.init(customView: actInd!);
        self.navigationItem.setLeftBarButton(barBtn, animated: true);
        
        self.fetchData(page: "\(pageNum)");
    }
    
    func fetchData(page: String) -> Void
    {
        let albumService: AlbumsService = AlbumsService();
        let userService: UsersService = UsersService();
        
        actInd?.startAnimating();
        
        albumService.GET(param: ["_page": page,"_limit": "10"] as AnyObject, successBlock: { (albums) in
            
            if(albums.count == 0) { self.actInd?.stopAnimating(); self.pageNum -= 1; return; }
            
            for album in albums
            {
                self.albums.append(album);
            }
            
            var userIDArray = [String]();
            for dict in albums
            {
                userIDArray.append(NSNumber.init(value: dict.userId).stringValue);
            }
            
            let orderSet = NSOrderedSet.init(array: userIDArray);
            userIDArray = orderSet.array as! [String];
            
            for userId in userIDArray
            {
                if(SimpleSharedCache.sharedInstance.getUser(key: "id\(userId)") == nil)
                {
                    userService.GET(param: ["id": userId] as AnyObject, successBlock: { () in
                        self.tableView?.reloadData();
                        self.actInd?.stopAnimating();
                    }, failureBlock: { (error) in
                        
                    });
                }
                else
                {
                    self.tableView?.reloadData();
                }
            }
            
            
        }, failureBlock: { (error) in
            
        });

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition
    {
        return .topAttached;
    }
    
    //TableView Delegate/DataSource

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.albums.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: AlbumCell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! AlbumCell;
        let album: AlbumModel = self.albums[indexPath.row];
        let user: UserModel? = SimpleSharedCache.sharedInstance.getUser(key: "id\(album.userId)");
        let username: String? = user?.name;
        cell.setCellContent(title: album.title, username: username);
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if((self.albums.count - 1) == indexPath.row)
        {
            pageNum += 1;
            self.fetchData(page: "\(pageNum)");
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let plService = PhotoAlbumService();
        let album: AlbumModel = self.albums[indexPath.row];
        actInd?.startAnimating();
        tableView.isUserInteractionEnabled = false;
        
        plService.GET(param: ["albumId": "\(album.id)"] as AnyObject, successBlock: { (aPhotos) in
            
            self.actInd?.stopAnimating();
            tableView.isUserInteractionEnabled = true;
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil);
            let vc: DetailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController;
            vc.aPhotos = aPhotos;
            self.navigationController?.pushViewController(vc, animated: true);
            
        }, failureBlock: { (error) in
            
        });
        
    }

}

