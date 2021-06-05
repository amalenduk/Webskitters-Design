//
//  BaseViewController.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // Custom initializers go here
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Layout
    
    // MARK: - User Interaction
    
    // MARK: - Additional Helpers
}


extension BaseViewController {
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
