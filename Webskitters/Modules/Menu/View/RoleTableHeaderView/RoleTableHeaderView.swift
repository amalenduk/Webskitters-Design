//
//  RoleTableHeaderView.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation
import UIKit

protocol RoleTableHeaderViewDelgate: AnyObject {
    func didTapOnHeaderView(on view: RoleTableHeaderView)
}

final class RoleTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var bottomView: UIView!
    
    // MARK: - Properties
    
    private var tapGesture: UITapGestureRecognizer?
    weak var delegate: RoleTableHeaderViewDelgate?
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTitleLabelAction(_ :)))
        titleLabel?.addGestureRecognizer(tapGesture!)
    }
    
    // MARK: - Additional Helper Functions
    
    public func configure(with role: Role, isSelected: Bool) {
        imageView.isHidden = !isSelected
        bottomView.isHidden = isSelected
        titleLabel.text = role.title
    }
    
    // MARK: - User Interactions
    
    @objc func tapTitleLabelAction(_ sender: UITapGestureRecognizer) {
        delegate?.didTapOnHeaderView(on: self)
    }
}
