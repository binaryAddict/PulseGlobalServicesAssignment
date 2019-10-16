//
//  Data+Extensions.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

extension Data {
    
    func string(using encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    func decodeJson<Value: Decodable>(_ type: Value.Type) throws -> Value {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Value.self, from: self)
    }
}
