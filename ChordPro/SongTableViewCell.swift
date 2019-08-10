//
//  SongTableViewCell.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/6/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var chordLabel: UILabel!
    @IBOutlet weak var capoLabel: UILabel!
    @IBOutlet weak var difficultyImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    
    
}
