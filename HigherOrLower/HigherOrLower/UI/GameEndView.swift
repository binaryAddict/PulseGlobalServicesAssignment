//
//  GameEndView.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import SwiftUI

struct GameEndView: View {
    
    struct Model {
        let card: Card
        let livesLeft: Int
        let correctGuesses: Int
    }
    
    let model: Model
    let didSelectPlayAgain: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Group {
                Text("You guessed \(model.correctGuesses) correct!")
                Spacer().frame(height: 8)
                if model.livesLeft > 0 {
                    Text("With \(model.livesLeft) lives left")
                } else {
                    Text("The last card was")
                    Spacer().frame(height: 8)
                    Text("\(model.card.displayValue)")
                }
            }
            Spacer()
            Button(action: didSelectPlayAgain) {
                HStack {
                   Spacer()
                   Text("Play Again")
                   Spacer()
                }
            }.padding(8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#if DEBUG
struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameEndView(
                model:.init(
                    card: Card(suit: .clubs, value: .ace),
                    livesLeft: 3,
                    correctGuesses: 5
                ),
                didSelectPlayAgain: { }
            )
            GameEndView(
                model:.init(
                    card: Card(suit: .clubs, value: .ace),
                    livesLeft: 0,
                    correctGuesses: 5
                ),
                didSelectPlayAgain: {}
            )
        }
    }
}
#endif
