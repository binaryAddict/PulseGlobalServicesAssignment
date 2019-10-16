//
//  Encodable+Extensions.swift
//  HigherOrLowerTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

extension Encodable {
    func encodeJson() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        return try encoder.encode(self)
    }
}
