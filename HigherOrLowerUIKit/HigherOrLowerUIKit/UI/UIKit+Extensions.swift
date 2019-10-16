//
//  UIKit+Extensions.swift
//  HigherOrLowerUIKit
//
//  Created by Dominic Campbell on 16/10/2019.
//

import UIKit

extension UIViewController {
    
    func addChild(_ viewController: UIViewController, to view: UIView) {
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        NSLayoutConstraint.constraints(
            withVisualFormats: [
                "V:|[viewControllerView]|",
                "H:|[viewControllerView]|"
            ],
            views: ["viewControllerView": viewController.view!]
        )
        viewController.didMove(toParent: self)
    }
    
    func fullyRemoveFromParent() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func fullyRemoveChildren() {
        children.forEach { $0.fullyRemoveFromParent() }
    }
}

extension UIView {

    @discardableResult func withSubviews(_ views: [UIView]) -> Self {
        views.forEach {
            addSubview($0)
        }
        return self
    }
    
    func withoutAutoresizingConstraints() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    @discardableResult func withSafeAreaView(_ view: UIView) -> Self {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        safeAreaLayoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        return self
    }
}

extension NSLayoutConstraint {
    
    @discardableResult class func constraints(withVisualFormats formats: [String], views: [String: Any]) -> [NSLayoutConstraint] {
        let constaints = formats.flatMap {
            constraints(withVisualFormat: $0, metrics: nil, views: views)
        }
        NSLayoutConstraint.activate(constaints)
        return constaints
    }
    
}

