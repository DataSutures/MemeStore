//
//  MemeCell.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/2/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.adjustsFontForContentSizeCategory = true
        type.adjustsFontForContentSizeCategory = true
    }
}
