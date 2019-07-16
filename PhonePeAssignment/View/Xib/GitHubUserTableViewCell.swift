//
//  GitHubUserTableViewCell.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 09/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import UIKit

class GitHubUserTableViewCell: UITableViewCell {

    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    
    @IBOutlet weak var reposBtn: UIButton!
    @IBOutlet weak var reposLbl: UILabel!
    @IBOutlet weak var reposCountLbl: UILabel!
    
    @IBOutlet weak var gistLbl: UILabel!
    @IBOutlet weak var gistCountLbl: UILabel!
    @IBOutlet weak var gistBtn: UIButton!
    
    @IBOutlet weak var followingBtn: UIButton!
    @IBOutlet weak var followingCountLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    
    @IBOutlet weak var viewHolder: UIView!
    
    @IBOutlet weak var avatarImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHolder.cardView()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
