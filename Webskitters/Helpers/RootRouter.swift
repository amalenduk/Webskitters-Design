//
//  RootRouter.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import UIKit

class RootRouter {
    
    /// Replaces the root view controller
    func setRootViewController(controller: UIViewController, animatedWithOptions: UIView.AnimationOptions?) {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
            fatalError("No window in app or below than iOS 13")
        }
        if let animationOptions = animatedWithOptions, window.rootViewController != nil {
            window.rootViewController = controller
            UIView.transition(with: window, duration: 0.33, options: animationOptions, animations: {
            }, completion: nil)
        } else {
            window.rootViewController = controller
        }
    }
    
    func loadMainAppStructure() {
        // Customize your app structure here
        let controller = Storyboard.Menu.viewController(for: MenuViewController.self)
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }
}
