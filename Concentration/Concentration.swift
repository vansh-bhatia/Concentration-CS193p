//
//  Concentration.swift
//  Concentration
//
//  Created by Vansh Bhatia on 2/26/22.
//  Copyright © 2022 Vansh Bhatia. All rights reserved.
//

import Foundation

class Concentration {
    var cards: Array<Card> = []
    var indexOfOnlyFaceUpCard: Int?{
        get{
            var foundIndex : Int?
            for index in cards.indices{
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else{
                        //2 face up cards found
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newVal){//can be renamed from newValue
            for index in cards.indices{
                cards[index].isFaceUp = (index==newVal)
            }
        }
    }

    init(numberOfPairOfCards: Int) {

        for _ in 1...numberOfPairOfCards {
            let card = Card()
            //let matchingCard = card //copy by value, struct
//            cards.append(card)
//            cards.append(card)
            cards += [card, card]

        }
        shuffleCards()

    }

    
    
    private func shuffleCards(){
        for index in cards.indices{
            let exchangeIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let temp = cards[index]
            cards[index] = cards[exchangeIndex]
            cards[exchangeIndex] = temp
        }
    }

    func gameOver()->Bool{
        for card in cards{
            if card.isMatched == false{
                return false
            }
        }
        print("game over")
        return true
    }
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp
//        if(cards[index].isFaceUp){
//            cards[index].isFaceUp=false
//        }
//        else{
//            cards[index].isFaceUp=true
//        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if(cards[matchIndex].identifier == cards[index].identifier) {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else {
                //either no cards or 2 cards face up
                
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    
    var delegate:ViewController?
    var flipCount = 0 {
        didSet {
            delegate?.flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
}
