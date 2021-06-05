//
//  TableView.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation
import UIKit

final class TableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
