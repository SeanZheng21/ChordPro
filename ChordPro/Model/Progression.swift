//
//  Progression.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/16/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class Progression {
    var text: String
    var chords: [String]
    var len: Int
    
    init(_ str: String) {
        self.text = str
        chords = []
        len = 0
        for chord in self.text.split(separator: " ") {
            chords.append(String(chord))
            len += 1
        }
    }
}
