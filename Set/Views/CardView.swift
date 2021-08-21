//
//  CardView.swift
//  Set
//
//  Created by Вадим Буркин on 21.07.2021.
//

import SwiftUI

struct CardView: View {
    
    let card: SetGame<Deck.SetCard>.Card
    @ObservedObject var game: SetCardGame
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ForEach(0..<card.content.numberOfShapes, id: \.self) { index in
                    game.createShape(for: card)
                        .frame(width: abs(geometry.size.width * DrawingConstants.shapeWidthMultiplier),
                               height: abs(geometry.size.height * DrawingConstants.shapeHeightMultiplier))
                        .foregroundColor(game.chooseUIColor(for: card.content.color))
                }
                Spacer()
            }
            .cardify(isFaceUp: card.isFaceUp, isSelected: card.isSelected, isDiscarded: card.isDiscarded, shadowColor: game.chooseShadowColor(for: card))
            .rotationEffect(rotationAngle(for: card))
        }
    }
    
    private func rotationAngle(for card: SetGame<Deck.SetCard>.Card) -> Angle {
        if !card.isFaceUp {
            if let firstCard = game.undealtCards.first,
               firstCard == card {
                return Angle(degrees: 9)
            }
        } else if card.isDiscarded {
            if let firstCard = game.discardPile.first,
               firstCard == card {
                return Angle(degrees: -9)
            }
        }
        
        return Angle(degrees: 0)
    }
    
    private struct DrawingConstants {
        static let shapeWidthMultiplier: CGFloat = 0.5
        static let shapeHeightMultiplier: CGFloat = 0.15
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetGame<Deck.SetCard>.Card(
            id: 1,
            content: Deck.SetCard(numberOfShapes: 3, color: .green, shape: .diamond, shading: .striped),
            isSelected: false,
            isMatched: true,
            isFaceUp: true
        )
        let game = SetCardGame()
        CardView(card: card, game: game)
            .frame(width: 300, height: 450)
    }
}
