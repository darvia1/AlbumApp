//
//  AlbumCell.swift
//  AlbumApp
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell
{
    @IBOutlet weak var titlelbl: UILabel?;
    @IBOutlet weak var usernamelbl: UILabel?;
    
    func setCellContent(title: String?, username: String?) -> Void
    {
        self.titlelbl?.text = title;
        self.usernamelbl?.text = username;
    }
    
    override func prepareForReuse()
    {
        self.titlelbl?.text = nil;
        self.usernamelbl?.text = nil;
    }
}
