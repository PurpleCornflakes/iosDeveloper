//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Qingling Zhang on 10/6/18.
//  Copyright © 2018 Qingling Zhang. All rights reserved.
//

import Foundation

class Concentration{
    let themes = ["Fruits","Dishes","Sports","Faces","Halloween","Animals"]
    lazy var theme = themes[Int(arc4random_uniform(UInt32(themes.count-1)))]
    
    var cards = [Card]()
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        // TODO: shuffle the cards
        var shuffledCards = [Card]()
        for _ in 0..<cards.count{
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count-1)))
            shuffledCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        cards = shuffledCards
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var identifierChosen = [Int:Bool?]()
    var score = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if identifierChosen[cards[matchIndex].identifier] != nil{
                        score -= 1
                    }else{
                        identifierChosen[cards[matchIndex].identifier] = true
                    }
                    if identifierChosen[cards[index].identifier] != nil{
                        score -= 1
                    }else{
                        identifierChosen[cards[index].identifier] = true
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil    // not one and only ...
            } else {
                // either no card or two cards face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
