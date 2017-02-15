//
//  ThumbCell.swift
//  AlbumApp
//
//  Created by adarvish on 15/02/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import UIKit

class ThumbCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView?;
    @IBOutlet weak var actInd: UIActivityIndicatorView?;
    
    override func awakeFromNib()
    {
        super.awakeFromNib();
        self.imageView?.layer.borderColor = UIColor.black.cgColor;
        self.imageView?.layer.borderWidth = 1;
    }
    
    override func prepareForReuse()
    {
        self.imageView?.image = nil;
    }
    
}
