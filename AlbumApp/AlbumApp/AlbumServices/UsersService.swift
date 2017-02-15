//
//  UsersService.swift
//  AlbumApp
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import Foundation

class UsersService: Service {
    
    override func path() -> String!
    {
        return "/users";
    }
    
    func GET(param: AnyObject?, successBlock: ((Void) -> Void)?, failureBlock: ((Error) -> Void)?)
    {
        super.GETRequest(param: param, successBlock: { (responseObject) in
            let values: NSArray = responseObject as! NSArray;
            for dict in values
            {
                let user: UserModel = UserModel();
                user.convertToObject(dict: dict as! NSDictionary);
                SimpleSharedCache.sharedInstance.setUser(object: user, key: "id\(user.id)")
            }
            successBlock?();
        }, failureBlock:{ (error) in
            failureBlock?(error);
        });
    }
    
}
