//
//  Concentration.swift
//  Concentration
//
//  Created by 2lup on 12.12.2021.
//

import Foundation



struct Concentration {
    
    var flipCount = 0
    
//    private(set) var flipCount = 0 {
//        didSet {
//            updateFlipCountLabel()
//        }
//    }
    
    var currentScore = 0
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private var indexOfSawCard = [Int]()
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if card match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    currentScore += 3
                }
                cards[index].isFaceUp = true
                if indexOfSawCard.contains(index) {
                    currentScore += -1
                }
                indexOfSawCard.append(index)
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                indexOfSawCard.append(index)
            }
        }
    }
    
    var themeSet = ["🦇😱🙀😈🎃👻🍭🍬🍎🕷",
                    "🐶🐱🐭🦊🐻🐨🐯🐮🐷🐵",
                    "🍏🍐🍊🍌🍉🍇🍑🥑🥝🥥",
                    "⚽️🏀🎱🥌🪀🏓🏒🎾🥊🏈"]
    
    lazy var emojiChoices = themeSet[themeSet.count.arc4random]
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: shuffle the cards
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
