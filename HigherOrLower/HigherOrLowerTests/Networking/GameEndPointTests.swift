//
//  GameEndPointTests.swift
//  HigherOrLowerTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLower
import Combine

private let validCardsResult = [Card(suit: .clubs, value: .ace), Card(suit: .clubs, value: .ten)]
private let validCardsData = try! validCardsResult.encodeJson()

class GameEndPointTests: XCTestCase {
    
    func testFetchFactory_moreThan1Card_success() {
        URLRequestStubbing.addStub(host: "cards.davidneal.io",path: "/api/cards", statusCode: 200, data: validCardsData)
        var subscriber: AnyCancellable?
        waitOnExpectation { expectation in
            subscriber = GameEndPoint
                .fetchFactory()
                .sink(
                    receiveCompletion: {
                        $0.onFailure { _ in XCTFail() }
                        expectation.fulfill()
                    },
                    receiveValue: {
                        XCTAssertEqual($0, try! GameFactory(cards: validCardsResult))
                    }
                )
        }
        subscriber?.cancel()
        URLRequestStubbing.removeAllStubs()
    }
    
    func testFetchFactory_wrongData_error() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(host: "cards.davidneal.io",path: "/api/cards", statusCode: 200, data: data)
        var subscriber: AnyCancellable?
        waitOnExpectation { expectation in
            subscriber = GameEndPoint
            .fetchFactory()
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { _ in XCTFail() }
            )
        }
        subscriber?.cancel()
        URLRequestStubbing.removeAllStubs()
    }

}

