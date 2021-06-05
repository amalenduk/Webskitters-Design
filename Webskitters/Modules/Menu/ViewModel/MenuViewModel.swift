//
//  MenuViewModel.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

final class MenuViewModel: ViewModel {
    
    // MARK: - Properties
    
    var roleViewModels: [MenuNestedTableViewCellViewModel] = []
    
    var selectedSection: Int?
    
    private let roles: [Role] = [
        Role(title: "Role 1", id: UUID()),
        Role(title: "Role 2", id: UUID()),
        Role(title: "Role 3", id: UUID())
    ]
    
    init() {
        for role in roles {
            roleViewModels.append(MenuNestedTableViewCellViewModel(role: role))
        }
    }
    
    // MARK: - Addional Helper Functions
}
