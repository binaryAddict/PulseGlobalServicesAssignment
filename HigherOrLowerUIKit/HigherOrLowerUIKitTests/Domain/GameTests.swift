//
//  GameTests.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLowerUIKit

class GameTests: XCTestCase {

    func testGuessHigher_isHigher_success() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .four),
            .init(suit: .spades, value: .five),
        ])
        game.guessHigher()
        XCTAssertEqual(game.correctGuesses, 1)
        XCTAssertEqual(game.livesLeft, 3)
    }
    
    func testGuessHigher_isNotHigher_success() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .four),
            .init(suit: .spades, value: .four),
        ])
        game.guessHigher()
        XCTAssertEqual(game.correctGuesses, 0)
        XCTAssertEqual(game.livesLeft, 2)
    }
    
    func testGuessHigher_isFinish_doesNothing() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .four),
            .init(suit: .spades, value: .five),
        ])
        game.guessHigher()
        game.guessHigher()
        XCTAssertEqual(game.correctGuesses, 1)
        XCTAssertEqual(game.livesLeft, 3)
    }
    
    func testGuessLower_isLower_success() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .five),
            .init(suit: .spades, value: .four),
        ])
        game.guessLower()
        XCTAssertEqual(game.correctGuesses, 1)
        XCTAssertEqual(game.livesLeft, 3)
    }
    
    func testGuessLower_isNotLower_success() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .four),
            .init(suit: .spades, value: .four),
        ])
        game.guessLower()
        XCTAssertEqual(game.correctGuesses, 0)
        XCTAssertEqual(game.livesLeft, 2)
    }
    
    func testGuessLower_isFinish_doesNothing() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .five),
            .init(suit: .spades, value: .four),
        ])
        game.guessLower()
        game.guessLower()
        XCTAssertEqual(game.correctGuesses, 1)
        XCTAssertEqual(game.livesLeft, 3)
    }
    
    func testIsFinish_outOfCards_true() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .four),
            .init(suit: .spades, value: .five),
            .init(suit: .spades, value: .six),
            .init(suit: .spades, value: .seven),
        ])
        XCTAssertEqual(game.isFinished, false)
        game.guessHigher()
        XCTAssertEqual(game.isFinished, false)
        game.guessHigher()
        XCTAssertEqual(game.isFinished, false)
        game.guessHigher()
        XCTAssertEqual(game.isFinished, true)
        XCTAssertEqual(game.correctGuesses, 3)
        XCTAssertEqual(game.livesLeft, 3)
    }
    
    func testIsFinish_outOfLives_true() {
        var game = Game(cards: [
            .init(suit: .clubs, value: .four),
            .init(suit: .spades, value: .five),
            .init(suit: .spades, value: .six),
            .init(suit: .spades, value: .seven),
            .init(suit: .spades, value: .eight),
            .init(suit: .spades, value: .nine),
            .init(suit: .spades, value: .ten),
        ])
        XCTAssertEqual(game.isFinished, false)
        game.guessLower()
        XCTAssertEqual(game.isFinished, false)
        game.guessLower()
        XCTAssertEqual(game.isFinished, false)
        game.guessLower()
        XCTAssertEqual(game.isFinished, true)
        XCTAssertEqual(game.correctGuesses, 0)
        XCTAssertEqual(game.livesLeft, 0)
    }
    
}
