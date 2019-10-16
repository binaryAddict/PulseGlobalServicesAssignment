//
//  GameFactoryTests.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLowerUIKit

class GameFactoryTests: XCTestCase {

    func testInit_lessThan2Cards_throws() {
        XCTAssertThrowsError( try GameFactory(cards: [Card(suit: .clubs, value: .ace)]) )
    }

    func testInit_moreThan1Card_success() {
        XCTAssertNoThrow(try GameFactory(cards: [Card(suit: .clubs, value: .ace), Card(suit: .clubs, value: .ten)]))
    }

}
