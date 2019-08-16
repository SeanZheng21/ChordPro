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
            [
            Progression("G C D G"),
            Progression("A D E A"),
            Progression("C F G C"),
            Progression("D G A D"),
            Progression("E A B E"),
            ],
            [
            Progression("G Am D G"),
            Progression("A Bm E A"),
            Progression("C Dm G C"),
            Progression("D Em A D"),
            Progression("E Fm B E"),
            ],
            [
            Progression("G Em C G"),
            Progression("A Fm D E"),
            Progression("C Am F G"),
            Progression("D Bm G A"),
            Progression("E Cm A B"),
            ],
            [
            Progression("G Em Am D"),
            Progression("A Fm Bm E"),
            Progression("C Am Dm G"),
            Progression("D Vm Em A"),
            Progression("E Cm Fm B"),
            ],
            [
            Progression("G C Em D"),
            Progression("A D Fm E"),
            Progression("C F Am G"),
            Progression("D G Bm A"),
            Progression("E A Cm B"),
            ],
            [
            Progression("G D Em C"),
            Progression("A E Fm D"),
            Progression("C G Am F"),
            Progression("D A Bm G"),
            Progression("E B Cm A")
            ]
        ])
        return progressions
    }
}
