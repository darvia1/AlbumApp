//
//  AlbumsService.swift
//  AlbumApp
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import Foundation

class AlbumsService: Service
{
    override func path() -> String!
    {
        return "/albums";
    }
    
    func GET(param: AnyObject?, successBlock: (([AlbumModel]) -> Void)?, failureBlock: ((Error) -> Void)?)
    {
        super.GETRequest(param: param, successBlock: { (responseObject) in
            let values: NSArray = responseObject as! NSArray;
            var albums = [AlbumModel]();
            for dict in values
            {
                let album = AlbumModel();
                album.convertToObject(dict: dict as! NSDictionary);
                albums.append(album);
            }
            
            successBlock?(albums);
        }, failureBlock:{ (error) in
            failureBlock?(error);
        });
    }
}
