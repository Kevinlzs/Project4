//
//  ContentView.swift
//  Project4
//
//  Created by Kevin Lopez on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var gridSize = 4 // Default to 4 pairs
    @State private var cards: [Card] = []
    @State private var flippedIndices: [Int] = []
    
    let allEmojis = ["🔥", "🌟", "🎈", "🎃", "🍕", "🚀", "🎸", "⚽️", "🎹", "💎", "🎯", "🦄"]

    var body: some View {
        VStack {
            HStack {
                Picker("Choose Pairs", selection: $gridSize) {
                    ForEach([2, 4, 6], id: \.self) { size in
                        Text("\(size) Pairs")
                    }
                }
                .pickerStyle(.menu)
                .padding()
                
                Button("Reset Game") {
                    resetGame()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                    ForEach(cards.indices, id: \.self) { index in
                        CardView(card: cards[index])
                            .onTapGesture {
                                flipCard(at: index)
                            }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            resetGame()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    }
        
    
    func resetGame() {
        let selectedEmojis = allEmojis.shuffled().prefix(gridSize)
        let pairedEmojis = (selectedEmojis + selectedEmojis).shuffled()
        cards = pairedEmojis.map { Card(content: $0) }
        flippedIndices = []
    }
    
    func flipCard(at index: Int) {
        guard !cards[index].isMatched, flippedIndices.count < 2 else { return }
        
        cards[index].isFlipped.toggle()
        flippedIndices.append(index)
        
        if flippedIndices.count == 2 {
            checkForMatch()
        }
    }
    
    func checkForMatch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if cards[flippedIndices[0]].content == cards[flippedIndices[1]].content {
                cards[flippedIndices[0]].isMatched = true
                cards[flippedIndices[1]].isMatched = true
            } else {
                cards[flippedIndices[0]].isFlipped = false
                cards[flippedIndices[1]].isFlipped = false
            }
            flippedIndices = []
        }
    }
}

#Preview {
    ContentView()
}
