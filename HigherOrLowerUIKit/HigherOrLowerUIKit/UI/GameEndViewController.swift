//
//  GameEndViewController.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import UIKit

class GameEndViewController: UIViewController {
    
    private let messageLabel = UILabel().withoutAutoresizingConstraints().with {
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    private let retyButton = UIButton().withoutAutoresizingConstraints().with {
        $0.setTitle("Play Again", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    private let game: Game
    private let didRequestNewGame: () -> Void
    
    init(game: Game, didRequestNewGame: @escaping () -> Void) {
        self.game = game
        self.didRequestNewGame = didRequestNewGame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var text = "You guessed \(game.correctGuesses) correct!\n\n"
        text += game.livesLeft == 0
            ? "The last card was\n\n\(game.currentCard.displayValue)"
            : "With \(game.livesLeft) lives left"
        messageLabel.text = text
        retyButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        view.withSafeAreaView(
            UIView().withSubviews([
                messageLabel,
                retyButton
            ])
        )
        NSLayoutConstraint.constraints(
            withVisualFormats: [
                "V:|-(>=8)-[messageLabel]-(>=8)-[retyButton]-(8)-|",
                "H:|-(8)-[messageLabel]-(8)-|",
                "H:|-(8)-[retyButton]-(8)-|"
            ],
            views: [
                "messageLabel": messageLabel,
                "retyButton": retyButton
            ]
        )
        view.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor).with { $0.priority = UILayoutPriority(rawValue: 250) }.isActive = true
    }
    
    @objc private func retryTapped() {
        didRequestNewGame()
    }
}
