//
//  HelpView.swift
//  Wordle
//
//  Created by Hanson on 2022/4/7.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack (alignment:.leading) {
                Text(
"""
Guess the Astronomy Word in 6 tries.

Each guess must be valid base on the number of letters you choose.
Hit Enter button to submit.

After each guess the color borders change to show how close your guess was.
Green Border: Matched Word
Blue Border: Included Word
Red Border: None included

If you don't know what Astronomy Words are check the link below

Tap New Button to play again (After you win or lose)
"""
                )
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Image("AmongUs"))
            .foregroundColor(.orange)
            .multilineTextAlignment(.center)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("**X**")
                    }
                }
            }
        }
    }
}
