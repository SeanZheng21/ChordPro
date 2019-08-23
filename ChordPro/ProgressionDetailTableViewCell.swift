//
//  ProgressionDetailTableViewCell.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/17/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class ProgressionDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var chordLabel: UILabel!
    @IBOutlet weak var chordImageView: UIImageView!
    @IBOutlet weak var chordNumberLabel: UILabel!
    
    @IBOutlet weak var patternLabel: UILabel!
    @IBOutlet weak var patternNoteLabel: UILabel!
    
    
    @IBOutlet weak var chordKeyLabel: UILabel!
    @IBOutlet weak var chordTypeLabel: UILabel!
}
