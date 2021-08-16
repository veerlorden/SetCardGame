//
//  SetCardGameView.swift
//  Set
//
//  Created by Вадим Буркин on 03.07.2021.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var game: SetCardGame
    @Namespace private var dealingNamespace
    @Namespace private var discardingNamespace
    
    var body: some View {
        NavigationView {
            VStack {
                gameBody
                Divider()
                HStack {
                    Spacer()
                    deckBody
                    Spacer()
                    discardPileBody
                    Spacer()
                }
                .padding(.top)
            }
            .navigationBarTitle("SET", displayMode: .inline)
            .navigationBarItems(leading: Text("Deck: \(game.undealtCards.count)"),
                                trailing: restartButton)
            .padding(.horizontal)
        }
    }
    
    var gameBody: some View {
        AspectVGrid (items: game.cards, aspectRatio: CardConstants.aspectRatio) { card in
            CardView(card: card, game: game)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                .padding(CardConstants.cardPadding)
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
    }
    
    var deckBody: some View {
        VStack {
            ZStack {
                ForEach(game.undealtCards) { card in
                    CardView(card: card, game: game)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                }
            }
            .onTapGesture {
                withAnimation {
                    if game.cards.isEmpty {
                        game.deal()
                    } else {
                        game.deal(3)
                    }
                }
            }
            .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
            
            Text("Deck")
                .bold()
        }
    }
    
    var discardPileBody: some View {
        VStack {
            ZStack {
                ForEach(game.discardPile) { card in
                    CardView(card: card, game: game)
                        .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                }
                RoundedRectangle(cornerRadius: CardConstants.discardCornerRadius)
                    .strokeBorder(Color.gray)
            }
            .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
            
            Text("Discard Pile")
                .bold()
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                game.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let discardCornerRadius: CGFloat = 10
        static let cardPadding: CGFloat = 4
        static let aspectRatio: CGFloat = 2/3
        static let deckWidth: CGFloat = 70
        static let deckHeight = deckWidth / aspectRatio
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetCardGameView(game: game)
    }
}
