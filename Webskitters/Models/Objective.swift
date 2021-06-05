//
//  Objective.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

class Objective {
    let roleID: UUID
    let id: UUID
    let title: String
    
    let results: [Result] = [
        Result(title: "Key Results 1"),
        Result(title: "Key Results 2"),
        Result(title: "Key Results 3")
    ]
    
    init(title: String, id: UUID, roleID: UUID) {
        self.roleID = roleID
        self.id = id
        self.title = title
    }
}
