//
//  SettingsView.swift
//  Wordle
//
//  Created by Hanson on 2022/4/7.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dm:WordleDataModel
    @Environment(\.dismiss) var dismiss
    @State var n0 = 0
    var body: some View {
        NavigationView {
            VStack {
                Text("Number of letters")
                Picker("Letters", selection: $dm.NumOfLetters) {
                    ForEach(5...7, id:\.self) { num in
                        Text(String(num))
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of:dm.NumOfLetters) { _ in
                    n0 = dm.NumOfLetters
                    dm.newGame()
                }
                Spacer()
                Button {
                    dm.currentStat.games = 0
                    dm.currentStat.maxStreak = 0
                    dm.currentStat.streak = 0
                    dm.currentStat.frequencies = [Int](repeating:0, count: 6)
                } label: {
                    Text("Reset")
                }
            }.padding()
            .navigationTitle("Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(WordleDataModel())
    }
}
