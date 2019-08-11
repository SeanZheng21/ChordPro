//
//  ChordFactory.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/11/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation

class ChordFactory {
    static func getChords() -> [[Chord]] {
        var chords = [[Chord]]()
        chords.append(contentsOf: [[Chord("C"), Chord("C7"), Chord("Cadd9"), Chord("Cdim7"), Chord("Cm7"), Chord("Cmaj7")],
                                   [Chord("D"), Chord("DF"), Chord("Dm")],
                                   [Chord("E"), Chord("Em"), Chord("Em7")],
                                   [Chord("F"), Chord("FC"), Chord("Fm")],
                                   [Chord("G"), Chord("GB"), Chord("GF")],
                                   [Chord("A"), Chord("Am"), Chord("Asus")],
                                   [Chord("B"), Chord("Bm")]])
        return chords
    }
}
