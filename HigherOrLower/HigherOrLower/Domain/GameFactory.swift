//
//  GameFactory.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

enum GameError: Error {
    case notEnoughCards
}

struct GameFactory: Equatable {
    
    private let cards: [Card]
    
    init(cards: [Card]) throws {
        guard cards.count > 1 else {
            throw GameError.notEnoughCards
        }
        self.cards = cards
    }
    
    func makeGame() -> Game {
        return Game(cards: cards.shuffled())
    }
}
