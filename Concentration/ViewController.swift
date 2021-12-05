//
//  ViewController.swift
//  Concentration
//
//  Created by 2lup on 05.12.2021.
//

import UIKit

class ViewController: UIViewController {
 
    var flipcount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipcount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipcount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        //print("flipCard(withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.white
        }
    }
    
}
 
