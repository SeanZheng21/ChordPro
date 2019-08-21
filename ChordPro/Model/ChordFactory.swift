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
                                   [Chord("D"), Chord("DF"), Chord("Dm"), Chord("D7"), Chord("Dm7"), Chord("Dmaj7")],
                                   [Chord("E"), Chord("Em"), Chord("Em7"), Chord("E7")],
                                   [Chord("F"), Chord("FC"), Chord("Fm"), Chord("Fmaj7")],
                                   [Chord("G"), Chord("GB"), Chord("GF"), Chord("G7")],
                                   [Chord("A"), Chord("Am"), Chord("Asus"), Chord("A7"), Chord("Am7"), Chord("Amaj7")],
                                   [Chord("B"), Chord("Bm"), Chord("B7")]])
        return chords
    }
}
