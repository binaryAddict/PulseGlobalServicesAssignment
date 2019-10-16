//
//  URLSession+ExtensionsTests.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLowerUIKit

private enum SomeError: Error, Equatable {
    case something
}

class URLSession_ExtensionsTests: XCTestCase {

    func testFetch_200ValidData_success() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(path: "/fetch", statusCode: 200, data: data)
        waitOnExpectation { expectation in
            URLSession.shared.fetch(with:  URL(string: "http://test.com/fetch")!) {
                XCTAssertEqual($0.successValue, data)
                XCTAssertNotEqual($0.successValue, "somethingElse".data(using: .utf8)!)
                expectation.fulfill()
            }
        }
        URLRequestStubbing.removeAllStubs()
    }
    
    func testFetch_300ValidData_invalidStatusCode() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(path: "/fetch", statusCode: 300, data: data)
        waitOnExpectation { expectation in
            URLSession.shared.fetch(with:  URL(string: "http://test.com/fetch")!) {
                XCTAssertEqual($0.failureError as? NetworkError, NetworkError.unsuccessfulHTTPStatusCode(300))
                expectation.fulfill()
            }
        }
        URLRequestStubbing.removeAllStubs()
    }
    
    func testFetch_199ValidData_invalidStatusCode() {
        let data = "hello".data(using: .utf8)!
        URLRequestStubbing.addStub(path: "/fetch", statusCode: 199, data: data)
        waitOnExpectation { expectation in
            URLSession.shared.fetch(with:  URL(string: "http://test.com/fetch")!) {
                XCTAssertEqual($0.failureError as? NetworkError, NetworkError.unsuccessfulHTTPStatusCode(199))
                expectation.fulfill()
            }
        }
        URLRequestStubbing.removeAllStubs()
    }
    
    func testFetch_error_error() {
        URLRequestStubbing.addStub(path: "/fetch", error: SomeError.something)
        waitOnExpectation { expectation in
            URLSession.shared.fetch(with:  URL(string: "http://test.com/fetch")!) {
                XCTAssertEqual($0.failureError as? SomeError, SomeError.something)
                expectation.fulfill()
            }
        }
        URLRequestStubbing.removeAllStubs()
    }
}
