//
//  Cardify.swift
//  Set
//
//  Created by Вадим Буркин on 13.08.2021.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    var isSelected: Bool
    var isDiscarded: Bool
    var shadowColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
            let faceUpCard = shape
                .fill(isSelected ? Color("SelectedCardColor") : .white)
                .shadow(color: shadowColor, radius: DrawingConstants.cardCornerRadius / 2, x: 0, y: 2)
            let faceDownCard = shape.fill(Color.green)
            let border = shape.stroke(lineWidth: 0.5)
            
            if isDiscarded {
                faceUpCard
                border
            } else if isFaceUp {
                faceUpCard
            } else {
                faceDownCard
                border
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cardCornerRadius: CGFloat = 10
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isDiscarded: Bool, shadowColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isDiscarded: isDiscarded, shadowColor: shadowColor))
    }
}
