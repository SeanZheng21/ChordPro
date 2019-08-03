//
//  Song.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class Song {
    
    let name: String
    let album: String
    let artist: String
    var lyric: [Line]
    
    init(_ name: String, _ album: String, _ artist: String) {
        self.name = name
        self.album = album
        self.artist = artist
        self.lyric = []
    }
    
    convenience init() {
        self.init("New Song", "Unknow Album", "Unknown Artist")
    }
    
}
