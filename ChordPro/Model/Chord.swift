//
//  Chord.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class Chord {
    
    enum ChordType: String {
        case Major
        case Minor
        case Diminished
        case Major_Seventh
        case Minor_Seventh
        case Dominant_Seventh
        case Suspended
        case Augmented
        case Slashed
        case Extended
        case Unknown
        
        static let descriptions: [ChordType: String] = [
            .Major: "Major chords sound happy and simple. A major chord consists of a root note (1st), a major third (+4 semitones), and a perfect 5th (+7 semitones). These are fundamental and most other chords are expanded or altered versions of major or minor chords.",
            .Minor: "Minor chords are considered to be sad, or serious. A minor chord consists of a root note (1st), a minor third (+3 semitones), and a perfect 5th (+7 semitones). Minor chords are written with the letter for the root note followed by an m (for minor). Besides the basic minor chords there are other categories that also use minor in the name, such are minor seventh, minor ninth, minor eleventh and minor thirteenth.",
            .Major_Seventh: "Major seventh chords are considered to be thoughtful, soft. The major 7th chord (abbreviated maj7 in chord names) is a four-note chord, but due to the characteristics of the guitar the chords can involve four to six notes (in some cases with duplicated notes). The major 7th is not to be confused with the dominant 7th. The chord is built by a root, a major third, a fifth and a major seventh.",
            .Minor_Seventh: "Minor seventh chords are considered to be moody, or contemplative. The minor 7th chord (abbreviated m7 in chord names) is a four-note chord, but due to the characteristics of the guitar, the chords can involve four to six notes (in some cases with duplicated notes). The minor 7th is similar to the dominant 7th, but is distinguished by its minor third. The chord is built by a root, a minor third, a fifth and a minor seventh.",
            .Dominant_Seventh: "Dominant seventh chords are considered to be strong and restless. The 7th Chord (also known as dominant 7th) adds another tone to the major triad chord. As the name implies, the added tone is seven steps from the root (following the scale). These chords are also called dominant chords, and they are especially common in blues.",
            .Suspended: "Sus chords are particularly common in pop music, and they sound bright and nervous. Sus is an abbreviation of suspension. A sus2 chord consists of a root note (1st), a major second (+2 semitones), and a perfect fifth (+7 semitones). Another way to think about them is they are major chords with a major second instead of a major third. Sometimes the name of the chord is written as \"Csus\" without any 2 or 4. In this case, you should treat it as a Csus4.",
            .Augmented: "Augmented chords sound anxious and suspenseful. An augmented chord consists of a root note (1st), a major third (+4 semitones), and an augmented 5th (+8 semitones). Another way to think about augmented chords is they are a major chord with the top note raised one semitone.",
            .Diminished: "Diminished Chords sound tense and unpleasant. A diminished chord consists of a root note (1st), a minor third (+3 semitones), and a diminished/flat fifth (+6 semitones).",
            .Slashed: "The slash chords (a.k.a. split chords) are named so because of the slash symbol in the chord name. For example C/D is a C chord with a D as the bass note. Therefore, it includes the notes D, C, E and G as opposed to a regular C chord including C, E and G. ",
            .Extended: "extended chords are tertian chords (built from thirds) or triads with notes extended, or added, beyond the seventh. Ninth, eleventh, and thirteenth chords are extended chords.",
            .Unknown: ""
            
        ]
        
        func typeName() -> String {
            return self.rawValue.replacingOccurrences(of: "_", with: " ")
        }
        func typeDescription() -> String? {
            return ChordType.descriptions[self]
        }
    }
    
    var name: String {
        didSet {
            self.key = String(name.prefix(1))
            self.type = Chord.getType(of: name)
        }
    }
    var key: String
    var type: ChordType
    
    init(_ name: String) {
        self.name = name
        self.key = String(name.prefix(1))
        self.type = Chord.getType(of: name)
    }
    
    static func getType(of chordName: String) -> Chord.ChordType {
        if chordName.contains("aug") {
            return .Augmented
        } else if chordName.contains("sus") {
            return .Suspended
        } else if chordName.contains("dim") {
            return .Diminished
        } else if chordName.hasSuffix("maj7") {
            return .Major_Seventh
        } else if chordName.hasSuffix("m7") {
            return .Minor_Seventh
        } else if chordName.contains("7") {
            return .Dominant_Seventh
        } else if chordName.contains("9") || chordName.contains("11") || chordName.contains("13") {
            return .Extended
        } else if chordName.count == 2 {
            if chordName.hasSuffix("m") {
                return .Minor
            } else {
                return .Slashed
            }
        } else if chordName.count == 1 {
            return .Major
        } else {
            return .Unknown
        }
        
    }
}
