//
//  Result.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

// MARK: - KeyResult
struct KeyResult: Codable {
    let id: Int?
    let keyResult, metrics: String?
    let objectiveID: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let type: Int?
    
    var title: String? {
        return keyResult
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case keyResult = "key_result"
        case metrics
        case objectiveID = "objective_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case type
    }
}
