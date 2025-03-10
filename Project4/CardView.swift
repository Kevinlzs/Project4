//
//  CardView.swift
//  Project4
//
//  Created by Kevin Lopez on 3/6/25.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let content: String
    var isFlipped = false
    var isMatched = false
}

struct CardView: View {
    let card: Card
        
    var body: some View {
        VStack {
            ZStack {
                if card.isFlipped || card.isMatched {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(height: 100)
                        .overlay(
                            Text(card.content)
                                .font(.largeTitle)
                        )
                        .border(Color.black)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(height: 100)
                }
            }
            .opacity(card.isMatched ? 0 : 1)
            .animation(.easeInOut, value: card.isMatched)
        }
    }
        
}

#Preview {
    CardView(card: Card(content: "Hello", isFlipped: false, isMatched: false))
}
