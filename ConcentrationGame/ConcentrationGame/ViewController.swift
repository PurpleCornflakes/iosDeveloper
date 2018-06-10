//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Qingling Zhang on 9/6/18.
//  Copyright © 2018 Qingling Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var FlipCountLabel: UILabel!
    var flipCount = 0{
        didSet{
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var ScoreLabel: UILabel!
    var score = 0{
        didSet{
            ScoreLabel.text = "Score:\(score)"
        }
    }
    @IBAction func restartGame(_ sender: UIButton) {
        flipCount = 0
        score = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = emojiChoicesOfThemes[game.theme]!
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            score = game.score
            updateViewFromModel()
        }else{
            print("Chosen card is not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
    }

    let emojiChoicesOfThemes = ["Fruits":["🍏","🍉","🍐","🍋","🍓","🍑","🍍","🥥"],
                                "Dishes":["🍣","🥟","🥗","🍘","🍰","🍜","🌮","🍔"],
                                "Sports":["⚽️","🏀","🏈","🏐","🎾","🏓","🎱","🏸"],
                                "Faces" :["😀","😉","🤓","😋","😚","😱","🤪","😤"],
                                "Halloween":["🎃","👻","😈","👿","👹","👺","🤡","💀"],
                                "Animals":["🙈","🐷","🐶","🦄","🐟","🐮","🐼","🐰"]]
    lazy var emojiChoices = emojiChoicesOfThemes[game.theme]!
    
    var emoji = [Int: String]()
    func emoji(for card:Card)-> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

