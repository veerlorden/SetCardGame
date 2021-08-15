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
    var shadowColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
            if isFaceUp {
                shape
                    .fill(isSelected ? Color("SelectedCardColor") : .white)
                    .shadow(color: shadowColor, radius: DrawingConstants.cardCornerRadius / 2, x: 0, y: 2)
            } else {
                shape
                    .fill(DrawingConstants.cardBackColor)
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cardBackColor: Color = .blue
        static let cardCornerRadius: CGFloat = 10
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, shadowColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, shadowColor: shadowColor))
    }
}
