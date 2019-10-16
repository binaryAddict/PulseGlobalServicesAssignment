//
//  XCTestCase+InvertableCodable.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import XCTest
@testable import HigherOrLowerUIKit

private let matchWhitespace = try! NSRegularExpression(pattern:"\\s*")

// url encoding changes "https://google.com/xx" to "https:\/\/google.com\/xx", lets undo for checks
private let matchEscapedSlash = try! NSRegularExpression(pattern:"\\\\/")

extension XCTestCase {
    /**
     Decode from file.
     Re-encode from instance.
     Check the file string matches the re-encode string (after clean for whitespace and url encoding adding slashes).
     
     The proves decode and encode for data that is invertible, non-invertible coding types will fail
     
     NOTE: Input json needs to be encoded using sorted keys and should have unmapped data stripped
     */
    func assertInvertible<T: Codable>(_ type: T.Type, forFile file: String, sourceFile: StaticString = #file, line: UInt = #line) {
        do {
            let fileData = try Bundle.test.data(forResource: file)
            let fileContentString = fileData.string() ?? ""
            let decoded = try fileData.decodeJson(type)
            var encodedContentString = try decoded.encodeJson().string() ?? ""
            encodedContentString = matchEscapedSlash.stringByReplacingMatches(in: encodedContentString, range: encodedContentString.nsRange, withTemplate: "/")
            let strippedFileContentString = matchWhitespace.stringByReplacingMatches(in: fileContentString, range: fileContentString.nsRange, withTemplate: "")
            let strippedEncodedContentString = matchWhitespace.stringByReplacingMatches(in: encodedContentString, range: encodedContentString.nsRange, withTemplate: "")
            XCTAssertNotEqual(
                strippedFileContentString,
                "",
                "file empty for \(file)",
                file: sourceFile,
                line: line
            )
            XCTAssertEqual(
                strippedFileContentString,
                strippedEncodedContentString,
                "for \(file):\n\nInput Content:\n\(fileContentString)\n\nDoes not match output:\n\(encodedContentString)\n\nNOTE: Input json needs to be encoded using sorted keys and have all unmapped data stripped\n\n",
                file: sourceFile,
                line: line
            )
        } catch {
            XCTFail(error.localizedDescription, file: sourceFile, line: line)
        }
    }
    
    func waitOnExpectation(
        timeout: TimeInterval = 20,
        description: String = #function,
        file: String = #file,
        line: Int = #line,
        testRunner: (XCTestExpectation) -> Void)
    {
        let expectation = self.expectation(description: description)
        testRunner(expectation)
        wait(for: [expectation], timeout: timeout)
    }
}

