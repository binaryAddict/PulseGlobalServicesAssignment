//
//  ViewController.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import UIKit

class RootViewController: UIViewController {
    
    private let spinnerView = UIActivityIndicatorView(style: .large).withoutAutoresizingConstraints()
    
    deinit {
        spinnerView.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(spinnerView)
        NSLayoutConstraint.constraints(
            withVisualFormats: [
                "V:|[spinnerView]|",
                "H:|[spinnerView]|"
            ],
            views: [ "spinnerView" : spinnerView ]
        )
        fetchGameFactory()
    }
    
    private func fetchGameFactory() {
        spinnerView.startAnimating()
        GameEndPoint.fetchFactory { result in
            DispatchQueue.main.async { [weak self] in
                self?.spinnerView.stopAnimating()
                switch result {
                case .failure:
                    let alertController = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
                    let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
                        self?.fetchGameFactory()
                    }
                    alertController.addAction(retryAction)
                    self?.present(alertController, animated: true, completion: {})
                case .success(let gameFactory):
                    self?.playGame(gameFactory: gameFactory)
                }
            }
        }
    }
    
    private func playGame(gameFactory: GameFactory) {
        fullyRemoveChildren()
        let playViewController = GamePlayViewController(game: gameFactory.makeGame()) { [weak self]  in
            guard let self = self else {
                return
            }
            let endViewController = GameEndViewController(game: $0) { [weak self]  in
                self?.playGame(gameFactory: gameFactory)
            }
            self.fullyRemoveChildren()
            self.addChild(endViewController, to: self.view)
        }
        addChild(playViewController, to: view)
    }
    
}

