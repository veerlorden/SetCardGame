//
//  SetGame.swift
//  Set
//
//  Created by Вадим Буркин on 23.07.2021.
//

protocol Matchable {
    static func match(cards: [Self]) -> Bool
}

struct SetGame<CardContent> where CardContent: Matchable {
    
    private(set) var deck: [Card]
    private(set) var cards: [Card]
    private(set) var numberOfCardsFromStart: Int
    private(set) var numberOfCardsToDeal: Int
    
    private var indicesOfSelectedCards: [Int] {
        cards.indices.filter { cards[$0].isSelected }
    }
    
    private var indicesOfMatchedCards: [Int] {
        cards.indices.filter { cards[$0].isMatched }
    }
    
    private var matchedCards: [Card] {
        cards.filter { $0.isMatched }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // Two cards already selected, we're tapping the third one
            if indicesOfSelectedCards.count == 2,
               !card.isSelected,
               !card.isMatched {
                cards[chosenIndex].isSelected = true
                // Full match, 3 cards form a set
                if CardContent.match(cards: indicesOfSelectedCards.map { cards[$0].content }) {
                    indicesOfSelectedCards.forEach { cards[$0].isMatched = true }
                }
                // Mismatch
                else {
                    indicesOfSelectedCards.forEach { cards[$0].isNotMatched = true }
                }
            }
            // Three cards already selected, we're tapping the fourth one
            else if indicesOfSelectedCards.count == 3 {
                // Three cards formed a set
                if indicesOfMatchedCards.count == 3 {
                    
                    if let selectedCardIndex = cards.firstIndex(where: { $0.id == card.id }) {
                        cards[selectedCardIndex].isSelected = true
                    }
                }
                // Three cards did not form a set
                else {
                    indicesOfSelectedCards.forEach {
                        cards[$0].isSelected = false
                        cards[$0].isNotMatched = false
                    }
                    cards[chosenIndex].isSelected = true
                }
            }
            // 0 or 1 card selected in total
            else {
                cards[chosenIndex].isSelected.toggle()
            }
        }
    }
    
    mutating func deal(_ numberOfCards: Int? = nil) {
        let numberOfCardsToRemoveFromDeck = numberOfCards ?? numberOfCardsFromStart
        guard deck.count >= numberOfCardsToRemoveFromDeck else { return }
        
        if indicesOfMatchedCards.count == 3 {
            cards = cards.filter { !$0.isMatched }
        }
        
        for _ in deck[0..<numberOfCardsToRemoveFromDeck] {
            cards.append(deck.removeLast())
        }
    }
    
    init(numberOfCardsInDeck: Int,
         numberOfCardsFromStart: Int,
         numberOfCardsToDeal: Int,
         createCardContent: (Int) -> CardContent) {
        
        deck = []
        cards = []
        
        self.numberOfCardsFromStart = numberOfCardsFromStart
        self.numberOfCardsToDeal = numberOfCardsToDeal
        
        for index in 0..<numberOfCardsInDeck {
            let content = createCardContent(index)
            deck.append(Card(id: index, content: content))
        }
        
        deck.shuffle()
        deal()
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        var isSelected = false
        var isMatched = false
        var isNotMatched = false
    }
}
