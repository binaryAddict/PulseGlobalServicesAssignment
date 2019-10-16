//
//  GameControllerView.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import SwiftUI

struct GameControllerView: View {
    
    init(gameFactory: GameFactory) {
        self.gameFactory = gameFactory
        self._game = State(initialValue: gameFactory.makeGame())
    }
    
    private let gameFactory: GameFactory
    @State private var game: Game
    
    var body: some View {
        content()
    }
    
    private func content() -> AnyView {
        if game.isFinished {
            return AnyView(GameEndView(
                model: .init(card: game.currentCard, livesLeft: game.livesLeft, correctGuesses: game.correctGuesses),
                didSelectPlayAgain: { self.game = self.gameFactory.makeGame() }
            ))
        } else {
            return AnyView(GamePlayView(
                model: .init(card: game.currentCard, livesLeft: game.livesLeft, correctGuesses: game.correctGuesses),
                didSelectHigher: { self.game.guessHigher() },
                didSelectLower: { self.game.guessLower() }
            ))
        }
    }
}

#if DEBUG
struct GameControllerView_Previews: PreviewProvider {
    static var previews: some View {
        GameControllerView(gameFactory: try! GameFactory(cards: Card.previewStubs))
    }
}
#endif
