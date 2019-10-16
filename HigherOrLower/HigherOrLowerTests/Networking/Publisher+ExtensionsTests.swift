//
//  Publisher+ExtensionsTests.swift
//  HigherOrLowerTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLower
import Combine

private func makePublisher() -> URLSession.DataTaskPublisher {
    return URLSession.shared.dataTaskPublisher(for: URL(string: "http://test.com/fetch")!)
}

class Publisher_ExtensionsTests: XCTestCase {

    func testValidateSuccessStatusCode_200ValidData_success() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(path: "/fetch", statusCode: 200, data: data)
        var subscriber: AnyCancellable?
        waitOnExpectation { expectation in
            subscriber = makePublisher()
                .validateSuccessStatusCode()
                .sink(
                    receiveCompletion: {
                        $0.onFailure { _ in XCTFail() }
                        expectation.fulfill()
                    },
                    receiveValue: {
                        XCTAssertEqual($0, data)
                    }
                )
        }
        subscriber?.cancel()
        URLRequestStubbing.removeAllStubs()
    }
    
    func testValidateSuccessStatusCode_300ValidData_invalidStatusCode() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(path: "/fetch", statusCode: 300, data: data)
        var subscriber: AnyCancellable?
        waitOnExpectation { expectation in
            subscriber = makePublisher()
                .validateSuccessStatusCode()
                .sink(
                    receiveCompletion: { _ in expectation.fulfill() },
                    receiveValue: { _ in XCTFail() }
                )
        }
        subscriber?.cancel()
        URLRequestStubbing.removeAllStubs()
    }
    
    func testValidateSuccessStatusCode_199ValidData_invalidStatusCode() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(path: "/fetch", statusCode: 199, data: data)
        var subscriber: AnyCancellable?
        waitOnExpectation { expectation in
            subscriber = makePublisher()
                .validateSuccessStatusCode()
                .sink(
                    receiveCompletion: { _ in expectation.fulfill() },
                    receiveValue: { _ in XCTFail() }
                )
        }
        subscriber?.cancel()
        URLRequestStubbing.removeAllStubs()
    }

}
