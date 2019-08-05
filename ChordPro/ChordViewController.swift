//
//  ChordViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/5/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class ChordViewController: UIViewController {
    
    var chord: Chord?
    var strumming: String?
    weak var song: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        chordNameLabel.text = "Chord: \(chord?.name ?? "nil")"
        chordImage.image = UIImage(named: chord?.name ?? "C")
        strummingLabel.text = strumming
        progressionLabel.text = song?.progression
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var chordNameLabel: UILabel!
    @IBOutlet weak var chordImage: UIImageView!
    @IBOutlet weak var strummingLabel: UILabel!
    @IBOutlet weak var progressionLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
