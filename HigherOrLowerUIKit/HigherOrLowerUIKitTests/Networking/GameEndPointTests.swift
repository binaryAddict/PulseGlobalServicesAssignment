//
//  GameEndPointTests.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLowerUIKit

private let validCardsResult = [Card(suit: .clubs, value: .ace), Card(suit: .clubs, value: .ten)]
private let validCardsData = try! validCardsResult.encodeJson()

class GameEndPointTests: XCTestCase {
    
    func testFetchFactory_validData_success() {
        URLRequestStubbing.addStub(host: "cards.davidneal.io",path: "/api/cards", statusCode: 200, data: validCardsData)
        waitOnExpectation { expectation in
            GameEndPoint.fetchFactory {
                XCTAssertEqual($0.successValue, try! GameFactory(cards: validCardsResult))
                expectation.fulfill()
            }
        }
        URLRequestStubbing.removeAllStubs()
    }
    
    func testFetchFactory_wrongData_error() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(host: "cards.davidneal.io",path: "/api/cards", statusCode: 200, data: data)
        waitOnExpectation { expectation in
            GameEndPoint.fetchFactory {
                XCTAssertNotNil($0.failureError)
                expectation.fulfill()
            }
        }
        URLRequestStubbing.removeAllStubs()
    }
}
