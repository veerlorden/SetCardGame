//
//  SetCardGameView.swift
//  Set
//
//  Created by Вадим Буркин on 03.07.2021.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var game: SetCardGame
    
    var body: some View {
        NavigationView {
            VStack {
                AspectVGrid (items: game.cards, aspectRatio: 2/3) { card in
                    CardView(card: card, game: game)
                        .padding(DrawingConstants.cardPadding)
                        .onTapGesture { game.choose(card) }
                }
                DealButton(game: game)
            }
            .navigationTitle("SET")
            .navigationBarItems(leading: Text("Deck: \(game.deck.count)"),
                                trailing: Button(action: {
                                    game.startNewGame()
                                }) { Text("New Game") })
            .padding(.horizontal)
        }
    }
    
    private struct DrawingConstants {
        static let cardPadding: CGFloat = 4
    }
}

struct DealButton: View {
    var game: SetCardGame
    
    var body: some View {
        Button(action: { game.deal(3) }) {
            Text("Deal 3 More Cards")
                .disabled(game.deck.isEmpty)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .stroke()
                .foregroundColor(game.deck.isEmpty ? .gray : .blue)
        )
        .padding(.top)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetCardGameView(game: game)
    }
}
