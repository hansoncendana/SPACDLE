//
//  GuessView.swift
//  Wordle
//
//  Created by Hanson on 2022/4/3.
//

import SwiftUI

struct GuessView: View {
    @Binding var guess: Guess
    @EnvironmentObject var dm:WordleDataModel

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0...dm.NumOfLetters - 1 , id: \.self) { index in
                FlipView(isFlipped: $guess.cardFlipped[index]) {
                    Text(guess.guessLetters[index])
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,      maxHeight: .infinity, alignment: .center)
                        .overlay(Rectangle().stroke(Color.systemBackground, lineWidth: 3))
                        .cornerRadius(5)
                } back: {
                    Text(guess.guessLetters[index])
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .overlay(Rectangle().stroke(guess.bgColors[index], lineWidth: 3))
                        .cornerRadius(5)
                }
                .font(.system(size: 35, weight: .heavy))
                .border (Color(.secondaryLabel))
            }
        }
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(guess: .constant(Guess(index:0)))
            .environmentObject(WordleDataModel())
    }
}
