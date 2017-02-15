//
//  PhotoAlbumService.swift
//  AlbumApp
//
//  Created by adarvish on 15/02/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class PhotoAlbumService: Service
{
    
    override func path() -> String!
    {
        return "/photos";
    }
    
    func GET(param: AnyObject?, successBlock: (([AlbumPhotoModel]) -> Void)?, failureBlock: ((Error) -> Void)?)
    {
        super.GETRequest(param: param, successBlock: { (responseObject) in
            let values: NSArray = responseObject as! NSArray;
            var aPhotos = [AlbumPhotoModel]();
            for dict in values
            {
                let aPhoto = AlbumPhotoModel();
                aPhoto.convertToObject(dict: dict as! NSDictionary);
                aPhotos.append(aPhoto);
            }
            
            successBlock?(aPhotos);
        }, failureBlock:{ (error) in
            failureBlock?(error);
        });
    }


}
