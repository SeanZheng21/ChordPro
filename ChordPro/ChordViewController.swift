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
        chordImage.image = UIImage(named: (chord?.name == nil || chord?.name == "") ? "NC" : "chord_" + (chord?.name)!)
        strummingLabel.text = strumming
        progressionLabel.text = song?.progression
        songNameLabel.text = "\(song?.name ?? "This song")'s chord progression:"
        setChordProgressionImages(to: song?.progression ?? "")
    }
    
    @IBOutlet weak var chordNameLabel: UILabel!
    @IBOutlet weak var chordImage: UIImageView!
    @IBOutlet weak var strummingLabel: UILabel!
    @IBOutlet weak var progressionLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet var chordProgressionCollectionImageView: [UIImageView]!
    @IBOutlet var chordProgressionCollectionLabel: [UILabel]!
    
    func setChordProgressionImages(to progression: String) {
        let songChords = progression.split(separator: " ")
        if songChords.count >= 4 {
            for i in 0..<4 {
                chordProgressionCollectionImageView[i].image = UIImage(named: "chord_" + String(songChords[i]))
                chordProgressionCollectionLabel[i].text = String(songChords[i])
            }
        } else {
            for i in 0..<songChords.count {
                chordProgressionCollectionImageView[i].image = UIImage(named: "chord_" + String(songChords[i]))
            }
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
