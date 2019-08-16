//
//  ProgressionTableViewCell.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/16/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class ProgressionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var chordImageViewCollection: [UIImageView]!
    @IBOutlet var chordLabelCollection: [UILabel]!
}
