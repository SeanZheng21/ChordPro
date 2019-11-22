//
//  SongFactory.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class SongFactory {
    static func getLyric(of songName: String) -> [Line] {
        var lineStrings: [String] = []
        if let filepath = Bundle.main.path(forResource: songName, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let lines = contents.split { $0.isNewline }
                for line in lines {
                    lineStrings.append(String(line))
                }
            } catch {
                print("Unable to access file under path: \(filepath)")
            }
        } else {
            print("Song with name: \(songName) not found!")
        }
        var lines: [Line] = []
        for lineString in lineStrings {
            lines.append(Line(lineString))
        }
        return lines
    }
}
