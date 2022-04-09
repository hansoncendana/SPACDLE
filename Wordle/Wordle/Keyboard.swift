//
//  Keyboard.swift
//  Wordle
//
//  Created by Hanson on 2022/4/3.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var dm: WordleDataModel
    @State private var showAlert = false
    var topRowKey = "QWERTYUIOP".map {String($0)}
    var midRowKey = "ASDFGHJKL".map {String($0)}
    var botRowKey = "ZXCVBNM".map {String($0)}
    
    var body: some View {
        VStack {
            HStack (spacing: 2) {
                ForEach(topRowKey, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dm.disabledKeys)
                .opacity(dm.disabledKeys ? 0.6 : 1)
            }
            HStack (spacing: 2) {
                ForEach(midRowKey, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dm.disabledKeys)
                .opacity(dm.disabledKeys ? 0.6 : 1)
            }
            HStack (spacing: 2) {
                Button {
                    dm.enterWord()
                    if dm.tryIndex == 6 {
                        showAlert = true
                    }
                }
                label: {
                    Text("Enter")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("You Lose"), message: Text("Try Again"), dismissButton: .default(Text("OK")))
                }
                .cornerRadius(15)
                .font(.system(size: 20).bold())
                .frame(width: 60, height: 50)
                .foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.unused, lineWidth: 1))
                .disabled(dm.currentWord.count < dm.NumOfLetters || !dm.inPlay)
                .opacity(dm.currentWord.count < dm.NumOfLetters || !dm.inPlay ? 0.6 : 1)
                ForEach(botRowKey, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dm.disabledKeys)
                .opacity(dm.disabledKeys ? 0.6 : 1)
                Button {
                    dm.removeWord()
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .font(.title)
                        .frame(width:60, height: 50)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .overlay(Rectangle().stroke(Color.unused, lineWidth: 1))
                }
                .disabled(!dm.inPlay || dm.currentWord.count == 0)
                .opacity((!dm.inPlay || dm.currentWord.count == 0) ? 0.6 : 1)
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
            .environmentObject(WordleDataModel())
            .scaleEffect(Global.keyboardScale)
    }
}
