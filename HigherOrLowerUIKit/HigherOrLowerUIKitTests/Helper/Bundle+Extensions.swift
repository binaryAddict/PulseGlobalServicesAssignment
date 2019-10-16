//
//  Bundle+Extensions.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

enum BundleError: Error {
    case noURLForResource(String)
}

extension Bundle {
    
    static var test: Bundle {
        return Bundle.allBundles.first(where: {
            $0.bundlePath.hasSuffix(".xctest")
        })!
    }
    
    func data(forResource resource: String) throws -> Data {
        guard let url = self.url(forResource: resource, withExtension: nil) else {
            throw BundleError.noURLForResource(resource)
        }
        return try Data(contentsOf: url)
    }
}
