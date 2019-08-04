//
//  Line.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class Line {
    
    var isStrumming: Bool
    var text: String
    
    // Format for lyric line:  (timeStamp, word, chord)
    // Format for strumming mark: (timeStamp, pattern, nil)
    var words: [(Double?, String, Chord?)]
    var content: String {
        didSet {
            if isStrumming {
                let (timeStamp, pattern) = parseStrumming(content)
                text = "Strumming: " + pattern
                words = []
                words.append((timeStamp, pattern, nil))
            } else {
                words = []
                for wordStr in content.components(separatedBy: " ") {
                    let (timeStamp, word, chord) = parseWord(wordStr)
                    text.append(word + " ")
                    words.append((timeStamp, word, chord))
                }
            }
        }
    }

    init(_ content: String) {
        self.text = ""
        self.content = content
        words = []
        isStrumming = content.hasSuffix("##Strumming##")
        if isStrumming {
            let (timeStamp, pattern) = parseStrumming(content)
            text = "Strumming: " + pattern
            words = []
            words.append((timeStamp, pattern, nil))
        } else {
            words = []
            for wordStr in content.components(separatedBy: " ") {
                let (timeStamp, word, chord) = parseWord(wordStr)
                text.append(word + " ")
                words.append((timeStamp, word, chord))
            }
        }
    }
    
    private func parseWord(_ str: String) -> (Double?, String, Chord?) {
        var timeStamp: Double?
        var word = ""
        var chord: Chord?
        
        let startIndex = str.startIndex
        let endIndex = str.endIndex
        var hasTimeStamp = false, hasChord = false
        if str.starts(with: "[") {
            hasTimeStamp = true
            let min = Int(str[str.index(startIndex, offsetBy: 1)...str.index(startIndex, offsetBy: 2)])!
            let sec = Int(str[str.index(startIndex, offsetBy: 4)...str.index(startIndex, offsetBy: 5)])!
            let ms = Int(str[str.index(startIndex, offsetBy: 7)...str.index(startIndex, offsetBy: 8)])!
            timeStamp = Double(min) * 60 + Double(sec) + Double(ms) / 100.0
        }
        if str.hasSuffix("}}") && str.contains("{{") {
            hasChord = true
            chord = Chord(String(str[str.index(str[str.range(of: "{{")!].startIndex, offsetBy: 2)..<str.index(endIndex, offsetBy: -2)]))
        }
        if hasTimeStamp {
            if hasChord {
                word = String(str[str.index(str.startIndex, offsetBy: 10)..<str.index(str[str.range(of: "{{")!].startIndex, offsetBy: 0)])
            } else {
                word = String(str[str.index(str.startIndex, offsetBy: 10)..<str.endIndex])
            }
        } else {
            if hasChord {
                word = String(str[str.startIndex..<str.index(str[str.range(of: "{{")!].startIndex, offsetBy: 0)])
            } else {
                word = String(str[startIndex..<endIndex])
            }
        }
        return (timeStamp, word, chord)
    }
    
    private func parseStrumming(_ str: String) -> (Double?, String) {
        let startIndex = str.startIndex
        let endIndex = str.endIndex

        let min = Int(str[str.index(startIndex, offsetBy: 1)...str.index(startIndex, offsetBy: 2)])!
        let sec = Int(str[str.index(startIndex, offsetBy: 4)...str.index(startIndex, offsetBy: 5)])!
        let ms = Int(str[str.index(startIndex, offsetBy: 7)...str.index(startIndex, offsetBy: 8)])!
        let timeStamp = Double(min) * 60 + Double(sec) + Double(ms) / 100.0
        let pattern = str[str.index(startIndex, offsetBy: 10)...str.index(endIndex, offsetBy: -14)]
        return (timeStamp, String(pattern))
    }
}
