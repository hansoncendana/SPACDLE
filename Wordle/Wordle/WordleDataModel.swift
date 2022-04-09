//
//  WordleDataModel.swift
//  Wordle
//
//  Created by Hanson on 2022/4/3.
//

import SwiftUI


class WordleDataModel: ObservableObject {
    
    @Published var guesses: [Guess] = []
    @Published var incorrectAttempts = [Int](repeating: 0, count: 6)
    @Published var showStats = false
    var NumOfLetters = 5
    var matchedLetters = [String]()
    var misplacedLetters = [String]()
    var keyColors = [String: Color]()
    var selectedWord = ""
    var currentWord = ""
    var tryIndex = 0
    var inPlay = false
    var gameOver = false
    var currentStat: Statistic
    
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    var disabledKeys: Bool {
        !inPlay || currentWord.count == NumOfLetters
    }
    
    init() {
        currentStat = Statistic.loadstat()
        newGame()
    }
    
    // Setup
    func newGame() {
        populateDefaults()
        if NumOfLetters == 5 {
            selectedWord = Global.spaceWords.randomElement()!
        } else if NumOfLetters == 6 {
            selectedWord = Global.spaceWords2.randomElement()!
        } else {
            selectedWord = Global.spaceWords3.randomElement()!
        }
        currentWord = ""
        inPlay = true
        tryIndex = 0
        gameOver = false
        print(selectedWord)
    }
    func populateDefaults() {
        guesses = []
        for index in 0...NumOfLetters {
            guesses.append(Guess(index:index))
        }
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors[String(char)] = .unused
        }
        matchedLetters = []
        misplacedLetters = []
    }
    
    // Game play
    func addToCurrentWord(_ letter:String) {
        currentWord += letter
        updateRow()
    }
    
    func enterWord() {
        if currentWord == selectedWord {
            setCurrentGuessColor()
            gameOver = true
            print("Win")
            setCurrentGuessColor()
            currentStat.update(win: true, index: tryIndex)
            inPlay = false
        }
        if verifyWord() {
            print("Valid Word")
            setCurrentGuessColor()
            tryIndex += 1
            currentWord = ""
            if tryIndex == 6 {
                currentStat.update(win: false)
                gameOver = true
                inPlay = false
                print("Lose")
            }
        } else {
            withAnimation {
                self.incorrectAttempts[tryIndex] += 1
            }
            incorrectAttempts[tryIndex] = 0
        }
    }
    func removeWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: NumOfLetters, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
    
    func setCurrentGuessColor() {
        let correctLetters = selectedWord.map {String($0) }
        var frequency = [String : Int]()
        for letter in correctLetters {
             frequency[letter, default:  0] += 1
        }
        for index in 0...NumOfLetters - 1{
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if guessLetter == correctLetter {
                guesses[tryIndex].bgColors[index] = .match
                if !matchedLetters.contains(guessLetter) {
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .match
                }
                if misplacedLetters.contains(guessLetter) {
                    if let index = misplacedLetters.firstIndex(where: {$0 == guessLetter}) {
                        misplacedLetters.remove(at: index)
                    }
                }
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...NumOfLetters - 1 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if correctLetters.contains(guessLetter)
                && guesses[tryIndex].bgColors[index] != .match
                && frequency[guessLetter]! > 0 {
                guesses[tryIndex].bgColors[index] = .included
                if !matchedLetters.contains(guessLetter) && !misplacedLetters.contains(guessLetter) {
                    misplacedLetters.append(guessLetter)
                    keyColors[guessLetter] = .included
                }
                frequency[guessLetter]! -= 1
            }
        }
        for index in 0...NumOfLetters - 1 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if keyColors[guessLetter] != .match
                && keyColors[guessLetter] != .included {
                keyColors[guessLetter] = Color.none
            }
        }
        flipCards(for: tryIndex)
    }
    
    func flipCards (for row:Int) {
        for col in 0...NumOfLetters - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {
                self.guesses[row].cardFlipped[col].toggle()
            }
        }
    }
}
