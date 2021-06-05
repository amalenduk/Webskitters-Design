//
//  MenuNestedTableViewCellViewModel.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

final class MenuNestedTableViewCellViewModel: ViewModel {
    
    // MARK: - Properties
    
    private let _role: Role
    
    var role: Role {
        return _role
    }
    
    var objectives: [Objective] {
        return role.objectives
    }
    
    var selectedObjectiveIndex: Int?
    
    init(role: Role) {
        self._role = role
    }
}
