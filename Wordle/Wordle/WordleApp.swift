//
//  WordleApp.swift
//  Wordle
//
//  Created by Hanson on 2022/4/2.
//

import SwiftUI

@main
struct WordleApp: App {
    @StateObject var dm = WordleDataModel()
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dm)
                .onAppear {
                    dm.NumOfLetters = 5
                    dm.currentStat.frequencies = [Int](repeating: 0, count: 6)
                    dm.currentStat.streak = 0
                    dm.currentStat.maxStreak = 0
                    dm.currentStat.games = 0
                }
        }
    }
}
