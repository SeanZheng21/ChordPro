//
//  ProgressionFactory.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/16/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class ProgressionFactory {
    static func getProgressions() -> [[Progression]] {
        var progressions = [[Progression]]()
        progressions.append(contentsOf: [
            [ // I IV V I
            Progression("G C D G"),
            Progression("A D E A"),
            Progression("C F G C"),
            Progression("D G A D"),
            Progression("E A B E"),
            ],
            [ // I II V I
            Progression("G Am D G"),
            Progression("A Bm E A"),
            Progression("C Dm G C"),
            Progression("D Em A D"),
            Progression("E Fm B E"),
            ],
            [ // I VI IV V
            Progression("G Em C G"),
            Progression("A Fm D E"),
            Progression("C Am F G"),
            Progression("D Bm G A"),
            Progression("E Cm7 A B"),
            ],
            [ // I VI II V
            Progression("G Em Am D"),
            Progression("A Fm Bm E"),
            Progression("C Am Dm G"),
            Progression("D Bm Em A"),
            Progression("E Cm7 Fm B"),
            ],
            [ // I IV VI V
            Progression("G C Em D"),
            Progression("A D Fm E"),
            Progression("C F Am G"),
            Progression("D G Bm A"),
            Progression("E A Cm7 B"),
            ],
            [ // I V VI IV
            Progression("G D Em C"),
            Progression("A E Fm D"),
            Progression("C G Am F"),
            Progression("D A Bm G"),
            Progression("E B Cm7 A")
            ]
        ])
        return progressions
    }
    
    static func getMode(for index: Int) -> String {
        let patterns = [
            0: "I IV V I",
            1: "I II V I",
            2: "I VI IV V",
            3: "I VI II V",
            4: "I IV VI V",
            5: "I V VI IV"
        ]
        return patterns[index] ?? " \(index)"
    }
}
