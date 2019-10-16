//
//  GamePlayViewController.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    private let livesLeftLabel = UILabel().withoutAutoresizingConstraints()
    private let correctGuessesLabel = UILabel().withoutAutoresizingConstraints().with {
        $0.textAlignment = .left
    }
    private let midAreaView = UIView().withoutAutoresizingConstraints()
    private let currentCardLabel = UILabel().withoutAutoresizingConstraints().with {
        $0.textAlignment = .center
    }
    private let messageLabel = UILabel().withoutAutoresizingConstraints().with {
        $0.text = "Is the next card \"Higher\" or \"Lower\"?"
        $0.textAlignment = .center
    }
    private let higherButton = UIButton().withoutAutoresizingConstraints().with {
        $0.setTitle("Higher", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    private let lowerButton = UIButton().withoutAutoresizingConstraints().with {
        $0.setTitle("Lower", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    private var game: Game
    private let didFinish: (Game) -> Void
    
    init(game: Game, didFinish: @escaping (Game) -> Void) {
        self.game = game
        self.didFinish = didFinish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        higherButton.addTarget(self, action: #selector(higherTapped), for: .touchUpInside)
        lowerButton.addTarget(self, action: #selector(lowerTapped), for: .touchUpInside)
        
        view.withSafeAreaView(
            UIView().withSubviews([
                livesLeftLabel,
                correctGuessesLabel,
                midAreaView.withSubviews([
                    currentCardLabel,
                    messageLabel
                ]),
                higherButton,
                lowerButton
            ])
        )
        NSLayoutConstraint.constraints(
            withVisualFormats: [
                "V:|-(8)-[livesLeftLabel]-(>=8)-[midAreaView]-(>=8)-[higherButton]-(8)-|",
                "V:|-(8)-[correctGuessesLabel(==livesLeftLabel)]",
                "V:|-(8)-[currentCardLabel]-(8)-[messageLabel]-(8)-|",
                "V:[lowerButton(==higherButton)]-(8)-|",
                "H:|-(16)-[livesLeftLabel]-(8)-[correctGuessesLabel]-(16)-|",
                "H:|[midAreaView]|",
                "H:|-(8)-[currentCardLabel]-(8)-|",
                "H:|-(8)-[messageLabel]-(8)-|",
                "H:|-(8)-[higherButton]-(8)-[lowerButton(==higherButton)]-(8)-|",
            ],
            views: [
                "livesLeftLabel": livesLeftLabel,
                "correctGuessesLabel": correctGuessesLabel,
                "midAreaView": midAreaView,
                "higherButton": higherButton,
                "lowerButton": lowerButton,
                "currentCardLabel": currentCardLabel,
                "messageLabel": messageLabel
            ]
        )
        view.centerYAnchor.constraint(equalTo: midAreaView.centerYAnchor).with { $0.priority = UILayoutPriority(rawValue: 250) }.isActive = true
        
        update()
    }
    
    private func update() {
        guard game.isFinished == false else {
            didFinish(game)
            return
        }
        livesLeftLabel.text = "Lives: \(game.livesLeft)"
        correctGuessesLabel.text = "Wins: \(game.correctGuesses)"
        currentCardLabel.text = game.currentCard.displayValue
    }
    
    @objc private func higherTapped() {
        game.guessHigher()
        update()
    }
    
    @objc private func lowerTapped() {
        game.guessLower()
        update()
    }
}
