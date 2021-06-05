//
//  Role.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

class Role {
    let id: UUID
    let title: String
    
    var objectives: [Objective] = []
    
    init(title: String, id: UUID) {
        self.id = id
        self.title = title
        
        objectives = [
            Objective(title: "Objective 1", id: UUID(), roleID: id),
            Objective(title: "Objective 2", id: UUID(), roleID: id),
            Objective(title: "Objective 3", id: UUID(), roleID: id)
        ]
    }
}
