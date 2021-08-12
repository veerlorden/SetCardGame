//
//  Deck.swift
//  Set
//
//  Created by Вадим Буркин on 12.07.2021.
//

struct Deck {
    
    private(set) var cards: [SetCard]
    
    init() {
        cards = []
        
        for number in 1...3 {
            for color in SetCard.Color.allCases {
                for shape in SetCard.Shape.allCases {
                    for shading in SetCard.Shading.allCases {
                        cards.append(SetCard(numberOfShapes: number,
                                          color: color,
                                          shape: shape,
                                          shading: shading))
                    }
                }
            }
        }
    }
    
    struct SetCard: Matchable {
        let numberOfShapes: Int
        let color: Color
        let shape: Shape
        let shading: Shading
        
        enum Shape: Int, CaseIterable {
            case oval = 1, diamond, squiggle
        }
        
        enum Shading: Int, CaseIterable {
            case solid = 1, striped, open
        }
        
        enum Color: Int, CaseIterable {
            case pink = 1, green, purple
        }
        
        static func match(cards: [Self]) -> Bool {
            guard cards.reduce(0, { $0 + $1.numberOfShapes }).isMultiple(of: 3),
                  cards.reduce(0, {$0 + $1.color.rawValue }).isMultiple(of: 3),
                  cards.reduce(0, {$0 + $1.shape.rawValue }).isMultiple(of: 3),
                  cards.reduce(0, {$0 + $1.shading.rawValue }).isMultiple(of: 3)
            else { return false }
            
            return true
        }
    }
}
