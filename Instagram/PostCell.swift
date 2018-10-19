//
//  PostCell.swift
//  Instagram
//
//  Created by Abraham De Alba on 10/19/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit
import ParseUI

class PostCell: UITableViewCell {
    
    @IBOutlet var imagePost: PFImageView!
    
    @IBOutlet weak var postCaption: UILabel!
    
    var instagramPost: PFObject!
    {
        didSet
        {
            self.imagePost.file = instagramPost["image"] as? PFFile
            self.imagePost.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
