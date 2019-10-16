//
//  Chainable.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

public protocol Chainable {}
extension Chainable {
    @discardableResult func with(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}
extension NSObject: Chainable {}
