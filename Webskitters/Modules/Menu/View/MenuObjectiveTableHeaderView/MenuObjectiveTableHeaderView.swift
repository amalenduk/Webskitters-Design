//
//  MenuObjectiveTableHeaderView.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import UIKit

protocol MenuObjectiveTableHeaderViewDelegate: AnyObject {
    func didTapOnHeaderView(on view: MenuObjectiveTableHeaderView)
}

class MenuObjectiveTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Properties
    
    private var tapGesture: UITapGestureRecognizer?
    weak var delegate: MenuObjectiveTableHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTitleLabelAction(_ :)))
        titleLabel?.addGestureRecognizer(tapGesture!)
    }
    
    // MARK: - Additional Helper Functions
    
    public func configure(with objective: Objective, isSelected: Bool) {
        titleLabel.text = objective.title
    }
    
    // MARK: - User Interactions
    
    @objc func tapTitleLabelAction(_ sender: UITapGestureRecognizer) {
        delegate?.didTapOnHeaderView(on: self)
    }
}
