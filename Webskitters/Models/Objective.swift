//
//  Objective.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

struct Objective: Codable {
    let id: Int?
    let contentObj: String?
    let score: String?
    let projectID: Int?
    let planningID: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let keyResult: [KeyResult]?
    let majorAction: [String]?
    
    var title: String {
        return contentObj ?? ""
    }
    
    var results: [KeyResult] {
        return keyResult ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case contentObj = "content_obj"
        case score
        case projectID = "project_id"
        case planningID = "planning_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case keyResult = "key_result"
        case majorAction = "major_action"
    }
}
