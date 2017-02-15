//
//  SimpleSharedCache.swift
//  AlbumApp
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class SimpleSharedCache: NSObject
{
    static let sharedInstance = SimpleSharedCache();
    
    private var usersDict: [String : UserModel];
    
    private var cache: NSCache<NSString, AnyObject>;
    
    override init()
    {
        self.cache = NSCache<NSString, AnyObject>();
        self.usersDict = [String : UserModel]();
        
        super.init();
    }
    
    func setCacheObject(object: AnyObject, key: NSString) -> Void
    {
        self.cache.setObject(object, forKey: key);
    }
    
    func  getCacheObject(key: NSString) -> UIImage?
    {
        return self.cache.object(forKey: key) as? UIImage;
    }
    
    func setUser(object: UserModel, key: String) -> Void
    {
        self.usersDict[key] = object;
    }
    
    func getUser(key: String) -> UserModel?
    {
        return self.usersDict[key];
    }
    
}
