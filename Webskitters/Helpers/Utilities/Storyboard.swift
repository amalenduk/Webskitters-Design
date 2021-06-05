//
//  Storyboard.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation
import UIKit

struct Storyboard {
    static let LaunchScreen: UIStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    static let Menu: UIStoryboard = UIStoryboard(name: "Menu", bundle: nil)
}

extension UIStoryboard {
    
    public func viewController<T: UIViewController>(for type: T.Type, withIdentifier identifier: String? = nil) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: identifier ?? String(describing: T.self)) as? T else { fatalError("Storyboard ID is missing or wrong") }
        return viewController
    }
}

