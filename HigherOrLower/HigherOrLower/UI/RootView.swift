//
//  ContentView.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import SwiftUI
import Combine

struct RootView: View {
    
    private static func makePublisher(x: Bool) -> AnyPublisher<Model, Never> {
        return GameEndPoint.fetchFactory()
            .map { Model.complete($0) }
            .catch { _ in Just(Model.error) }
            .receive(on: RunLoop.main )
            .eraseToAnyPublisher()
    }
    
    enum Model {
        case fetch
        case error
        case complete(GameFactory)
    }
    
    @State var model = Model.fetch
    @State var publisher = RootView.makePublisher(x: true)
    
    var body: some View {
        VStack(alignment: .leading) {
            content()
        }.onReceive(publisher) {
            self.model = $0
        }
    }
    
    private func content() -> AnyView {
        switch model {
        case .fetch:
            return AnyView(ActivityIndicatorView())
        case .error:
            return AnyView(ErrorView(didSelectRetry: retry))
        case .complete(let gameFactory):
            return AnyView(GameControllerView(gameFactory: gameFactory))
        }
    }
    
    private func retry() {
        self.publisher = RootView.makePublisher(x: false)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

