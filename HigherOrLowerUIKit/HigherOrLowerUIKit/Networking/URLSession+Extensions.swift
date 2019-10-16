//
//  URLSession+Extensions.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURLResponseType
    case unsuccessfulHTTPStatusCode(Int)
    case noData
}

extension URLSession {
    
    func fetch(with url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error  {
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkError.invalidURLResponseType))
                return
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                completionHandler(
                    .failure(
                        NetworkError.unsuccessfulHTTPStatusCode(httpResponse.statusCode)
                    )
                )
                return
            }
            guard let data = data else {
                // I dont think this case can happen in there is no error. It will just return empty Data
                completionHandler(.failure(NetworkError.noData))
                return
            }
            completionHandler(.success(data))
        }.resume()
    }
    
}
