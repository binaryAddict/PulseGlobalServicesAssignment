//
//  Subscriber+Extensions.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation
import Combine

extension Subscribers.Completion {
    
    func onFailure(_ action: (Failure) -> Void) {
        switch self {
        case .failure(let error):
            action(error)
        case .finished:
            break
        }
    }
}
