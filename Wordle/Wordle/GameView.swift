//
//  ContentView.swift
//  Wordle
//
//  Created by Hanson on 2022/4/2.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dm:WordleDataModel
    @State private var showSettings = false
    @State private var showHelp = false
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Spacer()
                    VStack(spacing: 3) {
                        ForEach(0...5, id:\.self) { index in
                            GuessView(guess: $dm.guesses[index])
                                .modifier(Shake(animatableData: CGFloat(dm.incorrectAttempts[index])))
                        }
                    }
                    .frame(width: Global.boardWidth, height: 6 * Global.boardWidth/5)
                    Spacer()
                    Keyboard()
                        .scaleEffect(Global.keyboardScale)
                        .padding(.top)
                        .cornerRadius(10)
                    Spacer()
                }
                .disabled(dm.showStats)
                .background(Image("Space2"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            if !dm.inPlay {
                                Button {
                                    dm.newGame()
                                } label: {
                                    Image(systemName: "goforward")
                                        .foregroundColor(.white)
                                }
                            }
                            Button {
                                showHelp.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                            .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement:.principal) {
                        Text("S P A C D L E")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement:.navigationBarTrailing) {
                        HStack {
                            Button {
                                withAnimation {
                                    dm.showStats.toggle()
                                }
                            } label: {
                                Image(systemName:"chart.bar")
                            }
                            .foregroundColor(.white)
                            Button {
                                showSettings.toggle()
                            } label: {
                                Image(systemName: "gearshape.fill")
                            }
                            .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
            .sheet(isPresented: $showHelp) {
                HelpView()
            }
            if dm.showStats {
                StatsView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(WordleDataModel())
    }
}
