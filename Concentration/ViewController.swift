//
//  ViewController.swift
//  Concentration
//
//  Created by 2lup on 05.12.2021.
//

import UIKit

class ViewController: UIViewController {
 
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Count: \(game.currentScore)"
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        game.flipCount = 0
        updateFlipCountLabel()
        game.currentScore = 0
        updateScoreLabel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        updateFlipCountLabel()
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in cardButtons")
        }
        updateScoreLabel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            //print(index)
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    
    //private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    //private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎🕷"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, game.emojiChoices.count > 0 {
            let randomStringIndex = game.emojiChoices.index(game.emojiChoices.startIndex, offsetBy: game.emojiChoices.count.arc4random)
            emoji[card] = String(game.emojiChoices.remove(at: randomStringIndex))
            //print(card.identifier)
        }

        return emoji[card] ?? "?"
    }
}
 
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
