//
//  CardTests.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLowerUIKit

class CardTests: XCTestCase {
    
    func testCodable() {
        assertInvertible([Card].self, forFile: "Card_AllCards.json")
    }
    
    func testCardValueComparable() {
        let cardValues = [
            Card.Value.ace,
            Card.Value.two,
            Card.Value.three,
            Card.Value.four,
            Card.Value.five,
            Card.Value.six,
            Card.Value.seven,
            Card.Value.eight,
            Card.Value.nine,
            Card.Value.ten,
            Card.Value.jack,
            Card.Value.queen,
            Card.Value.king,
        ]
        let reversedCardValues: [Card.Value] = cardValues.reversed()
        (0..<cardValues.count-1).forEach { i in
            XCTAssertLessThan(cardValues[i], cardValues[i+1])
            XCTAssertGreaterThan(reversedCardValues[i], reversedCardValues[i+1])
        }
    }
}
