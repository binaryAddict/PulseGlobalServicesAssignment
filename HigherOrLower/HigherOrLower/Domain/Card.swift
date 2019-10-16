//
//  Card.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

struct Card: Codable, Equatable {
    
    let suit: Suit
    let value: Value
    
    var displayValue: String {
        return "\(value.displayValue) of \(suit.displayValue)"
    }
    
    enum Suit: String, Codable {
        case spades
        case clubs
        case diamonds
        case hearts
        
        var displayValue: String {
            return String(describing: self)
        }
    }
    
    enum Value: String, Codable, Comparable {
        case ace = "A"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case jack = "J"
        case queen = "Q"
        case king = "K"
    
        var numbericValue: Int {
            switch self {
                case .ace: return 1
                case .two: return 2
                case .three: return 3
                case .four: return 4
                case .five: return 5
                case .six: return 6
                case .seven: return 7
                case .eight: return 8
                case .nine: return 9
                case .ten: return 10
                case .jack: return 11
                case .queen: return 12
                case .king: return 13
            }
        }
        
        var displayValue: String {
            return String(describing: self)
        }
        
        static func < (lhs: Card.Value, rhs: Card.Value) -> Bool {
            return lhs.numbericValue < rhs.numbericValue
        }
    }
}

#if DEBUG
extension Card {
    static var previewStubs = [
        Card(suit: .clubs, value: .four),
        Card(suit: .spades, value: .five),
    ]
}
#endif
