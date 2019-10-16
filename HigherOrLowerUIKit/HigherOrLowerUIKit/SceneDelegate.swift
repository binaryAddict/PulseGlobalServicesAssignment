//
//  SceneDelegate.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = RootViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

