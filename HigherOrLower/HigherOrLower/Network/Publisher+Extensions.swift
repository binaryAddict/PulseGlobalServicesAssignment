//
//  Publisher+Extensions.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURLResponseType
    case unsuccessfulHTTPStatusCode(Int)
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output, Failure == URLError {
    func validateSuccessStatusCode() -> AnyPublisher<Data, Error> {
        return tryMap {
            guard let httpResponse = $0.response as? HTTPURLResponse else {
                throw NetworkError.invalidURLResponseType
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.unsuccessfulHTTPStatusCode(httpResponse.statusCode)
            }
            return $0.data
        }.eraseToAnyPublisher()
    }
}

