//
//  ErrorView.swift
//  HigherOrLower
//
//  Created by Dominic Campbell on 16/10/2019.
//

import SwiftUI

struct ErrorView: View {
    
    let didSelectRetry: () -> Void
    
    var body: some View {
        VStack() {
            Spacer()
            Text("Error")
            Spacer()
            Button(action: didSelectRetry) {
                HStack {
                   Spacer()
                   Text("Retry")
                   Spacer()
                }
            }.padding(8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(didSelectRetry:{})
    }
}
