//
//  Card.swift
//  Concentration
//
//  Created by Vansh Bhatia on 2/26/22.
//  Copyright © 2022 Vansh Bhatia. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier()->Int{
        identifierFactory+=1
        return identifierFactory
    }
    init(){
        self.identifier=Card.getUniqueIdentifier()
    }
}
