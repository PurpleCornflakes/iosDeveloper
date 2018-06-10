//
//  Card.swift
//  ConcentrationGame
//
//  Created by Qingling Zhang on 10/6/18.
//  Copyright © 2018 Qingling Zhang. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier:Int
    static var identifierFactory = 0
    static func getUniqueIdentifier()-> Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
