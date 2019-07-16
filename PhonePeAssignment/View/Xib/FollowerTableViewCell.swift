//
//  FollowerTableViewCell.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 12/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var avtarImgView: UIImageView!
    @IBOutlet weak var loginLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewHolder.cardView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
