//
//  StatsView.swift
//  Wordle
//
//  Created by Hanson on 2022/4/10.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dm:WordleDataModel
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        dm.showStats.toggle()
                    }
                } label: {
                    Text("**X**")
                }
                .offset(x:20, y: 10)
            }
            Text("STATISTICS")
                .font(.headline)
                .fontWeight(.bold)
            HStack(alignment:.top) {
                SingleStat(value: dm.currentStat.games, text: "Played")
                if dm.currentStat.games != 0 {
                    SingleStat(value: Int(100 * dm.currentStat.wins/dm.currentStat.games), text: "Win %")
                }
                SingleStat(value: dm.currentStat.streak, text: "Current Streak")
                    .fixedSize(horizontal: false, vertical: true)
                SingleStat(value: dm.currentStat.maxStreak, text: "Max Streak")
                    .fixedSize(horizontal: false, vertical: true)
            }
            Text("GUESS DISTRIBUTION")
                .font(.headline)
                .fontWeight(.bold)
            VStack(spacing: 5) {
                ForEach (0..<6) { index in
                    HStack {
                        Text("\(index + 1)")
                        if dm.currentStat.frequencies[index] == 0 {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 22, height: 20)
                                .overlay(Text("0").foregroundColor(.white))
                        } else {
                            if let maxValue = dm.currentStat.frequencies.max() {
                                Rectangle().fill((dm.tryIndex == index && dm.gameOver) ? Color.match : Color.none)
                                    .frame(width: CGFloat(dm.currentStat.frequencies[index]) / CGFloat(maxValue) * 210, height: 20)
                                    .overlay(
                                        Text("\(dm.currentStat.frequencies[index])")
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 5),
                                        alignment:.trailing)
                            }
                        }
                        Spacer()
                    }
                }
            }
            let answer = dm.selectedWord
            if !dm.inPlay {
                Rectangle()
                    .frame(width: 100)
                    .foregroundColor(.gray)
                    .overlay(Text(answer))
            }
            Spacer()
        }
        .padding(.horizontal, 40)
        .frame(width: 320, height : 370)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(red: 135/255, green: 206/255, blue: 235/255)))
        .padding()
        .shadow(color: .black.opacity(0.3), radius: 10)
        .offset(y: -70)
        .onAppear {
            print(dm.currentStat)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(WordleDataModel())
    }
}

struct SingleStat:View {
    let value: Int
    let text: String
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.largeTitle)
            Text(text)
                .font(.caption)
                .frame(width: 50)
                .multilineTextAlignment(.center)
        }
    }
}
