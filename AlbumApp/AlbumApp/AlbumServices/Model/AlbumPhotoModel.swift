//
//  AlbumPhotoModel.swift
//  AlbumApp
//
//  Created by adarvish on 15/02/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class AlbumPhotoModel: NSObject {
    
    var id: Int = 0;
    var title: String? = nil;
    var url: String? = nil;
    var thumbnailUrl: String? = nil;
    
    func convertToObject(dict: NSDictionary)
    {
        let number: NSNumber = dict.object(forKey: "id") as! NSNumber;
        self.id = number.intValue;
        self.title = dict.object(forKey: "title") as? String ?? "";
        self.url = dict.object(forKey: "url") as? String ?? "";
        self.thumbnailUrl = dict.object(forKey: "thumbnailUrl") as? String ?? "";
    }
}
