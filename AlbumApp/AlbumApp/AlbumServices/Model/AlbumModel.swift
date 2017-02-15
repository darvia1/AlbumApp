//
//  AlbumsModel.swift
//  AlbumApp
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import Foundation

class AlbumModel: NSObject
{
    var id: Int = 0;
    var userId: Int = 0;
    var title: String? = nil;
    
    func convertToObject(dict: NSDictionary)
    {
        var number: NSNumber = dict.object(forKey: "id") as! NSNumber;
        self.id = number.intValue;
        
        number = dict.object(forKey: "userId") as! NSNumber;
        self.userId = number.intValue;
        
        self.title = dict.object(forKey: "title") as? String ?? "";
    }
}
