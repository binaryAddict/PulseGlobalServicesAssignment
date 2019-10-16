//
//  GamePlayView.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import SwiftUI

struct GamePlayView: View {
    
    struct Model {
        let card: Card
        let livesLeft: Int
        let correctGuesses: Int
    }
    
    let model: Model
    let didSelectHigher: () -> Void
    let didSelectLower: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Lives: \(model.livesLeft)")
                Spacer()
                Text("Wins: \(model.correctGuesses)")
            }
            Spacer()
            Group {
                Text("\(model.card.displayValue)")
                Spacer().frame(height: 8)
                Text("Is the next card \"Higher\" or \"Lower\"?")
            }
            Spacer()
            HStack {
                Button(action: didSelectHigher) {
                   HStack {
                      Spacer()
                      Text("Higher")
                      Spacer()
                   }
                }.padding(8)
                Spacer().frame(width: 8)
                Button(action: didSelectLower) {
                    HStack {
                       Spacer()
                       Text("Lower")
                       Spacer()
                    }
                }.padding(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayView(
            model:.init(
                card: Card(suit: .clubs, value: .ace),
                livesLeft: 3,
                correctGuesses: 5
            ),
            didSelectHigher: {},
            didSelectLower: {}
        )
    }
}
