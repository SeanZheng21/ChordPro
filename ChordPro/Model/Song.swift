//
//  Song.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
import UIKit
class Song {
    
    let name: String
    let album: String
    let artist: String
    let artwork: UIImage?
    var duration: Double?
    var progression: String?
    var capo: Int
    
    var lyric: [Line]
    
    init(_ name: String, _ album: String, _ artist: String, _ progression: String, _ capo: Int = 0) {
        self.name = name
        self.album = album
        self.artist = artist
        self.duration = 0
        self.artwork = UIImage(named: name)
        self.lyric = []
        self.capo = capo
        self.progression = progression
    }
    
    convenience init() {
        self.init("New Song", "Unknow Album", "Unknown Artist","")
    }
    
    func getLyrics(at time: Double) -> (String?, String?, Int?, Int?) {
        var previousI = 0, previousJ = 0
        for i in 0..<self.lyric.count {
            for j in 0..<self.lyric[i].words.count {
                let (timeStamp, _, _) = self.lyric[i].words[j]
                if let tS = timeStamp {
                    if tS > time {
                        let (_, _, ch) = self.lyric[previousI].words[previousJ]
                        return (self.lyric[previousI].text, ch?.name ?? "", previousI, previousJ)
                    } else {
                        previousI = i
                        previousJ = j
                    }
                }
            }
        }
        return (nil, nil, nil, nil)
    }
}
