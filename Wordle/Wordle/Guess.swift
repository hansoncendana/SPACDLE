//
//  Models.swift
//  Wordle
//
//  Created by Hanson on 2022/4/3.
//

import SwiftUI

struct Guess {
    let index: Int
    var word = "       "
    var bgColors = [Color](repeating: Color.none, count: 7)
    var cardFlipped = [Bool](repeating: false, count: 7)
    var guessLetters: [String] {
        word.map { String($0) }
    }
}
