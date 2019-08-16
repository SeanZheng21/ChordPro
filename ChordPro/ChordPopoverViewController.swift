//
//  ChordPopoverViewController.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/16/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import UIKit

class ChordPopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chordImageView.image = UIImage(named: "chord_" + chord.name)
        chordNameLabel.text = chord.name
    }
    
    // MARK: - Model
    var chord = Chord("C")
    
    // MARK: - Outlets
    @IBOutlet weak var chordImageView: UIImageView!
    @IBOutlet weak var chordNameLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
