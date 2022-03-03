//
//  ViewController.swift
//  Concentration
//
//  Created by Vansh Bhatia on 7/19/20.
//  Copyright © 2020 Vansh Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var flipCount = 0 {
//        didSet {
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
//    }
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        newGame()

    }
    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!


    override func viewDidLoad() {
        game.delegate = self
    }

    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCount += 1

        if let cardnumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardnumber)
            updateViewFromModel()
        } else {
            print("Card not in CardButtons")
        }

    }
    func newGame() {
        let alert = UIAlertController(title: "Game Over!", message: "Your score is \(game.flipCount)!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        present(alert, animated: true, completion: nil)
        game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)

        game.delegate = self
        game.flipCount = 0
        emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
        updateViewFromModel()
    }
    func updateViewFromModel() {
        if(game.gameOver()) {
            newGame()
        }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    var emoji: [Int: String] = [:]
    func emoji(for card: Card) -> String {

        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))

            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)

        }

        if let chosenEmoji = emoji[card.identifier] {
            return chosenEmoji
        }
        return "?"
    }

}

