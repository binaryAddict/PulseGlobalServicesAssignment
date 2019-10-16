//
//  GameEndPoint.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation
import Combine

struct GameEndPoint {
    
    static func fetchFactory() -> AnyPublisher<GameFactory, Error> {
        let url = URL(string: "https://cards.davidneal.io/api/cards")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .validateSuccessStatusCode()
            .decode(type: [Card].self, decoder: JSONDecoder())
            .tryMap { try GameFactory(cards: $0) }
            .eraseToAnyPublisher()
    }
    
}
