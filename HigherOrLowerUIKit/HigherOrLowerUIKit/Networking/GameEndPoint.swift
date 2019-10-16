//
//  CardsEndPoint.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

struct GameEndPoint {

    static func fetchFactory(_ completionHandler: @escaping (Result<GameFactory, Error>) -> Void) {
        let url = URL(string: "https://cards.davidneal.io/api/cards")!
        URLSession.shared.fetch(with: url) {
            let reult = $0.flatMap { data -> Result<GameFactory, Error> in
                do {
                    return .success(try GameFactory(cards: data.decodeJson([Card].self)))
                } catch {
                    return .failure(error)
                }
            }
            completionHandler(reult)
        }
    }
}
