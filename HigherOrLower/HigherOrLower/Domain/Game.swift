//
//  Game.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

struct Game {
    
    private var cards: [Card]
    private(set) var currentCard: Card
    private(set) var livesLeft = 3
    private(set) var correctGuesses = 0
    
    var isFinished: Bool {
        return livesLeft == 0 || cards.isEmpty
    }
    
    init(cards: [Card]) {
        self.cards = cards.reversed()
        self.currentCard = self.cards.removeLast()
    }
    
    mutating func guessHigher() {
        makeGuess {
            $0.current.value < $0.next.value
        }
    }
    
    mutating func guessLower() {
        makeGuess {
            $0.current.value > $0.next.value
        }
    }
    
    private typealias CompareTuple = (current: Card, next: Card)
    mutating private func makeGuess(action: (CompareTuple) -> Bool) {
        guard isFinished == false, let nextCard = cards.popLast() else {
            return
        }
        let isCorrect = action((current: currentCard, next: nextCard))
        livesLeft -= isCorrect ? 0 : 1
        correctGuesses += isCorrect ? 1 : 0
        currentCard = nextCard
    }
}

#if DEBUG
extension Game {
    static var previewStub = Game(cards: [
        .init(suit: .clubs, value: .four),
        .init(suit: .spades, value: .five),
    ])
}
#endif
