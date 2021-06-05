//
//  Role.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

// MARK: - Welcome
struct MenuData: Codable {
    let status: Bool
    let code: Int
    let data: [Role]?
    let message: String?
}

// MARK: - Datum
struct Role: Codable {
    let id: Int
    let roleName: String
    let roleType: Int?
    let company: String?
    let colour, order: String?
    let userID: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let planning: Planning?
    
    var objectives: [Objective] {
        return planning?.objective ?? []
    }
    
    var title: String {
        return roleName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case roleName = "role_name"
        case roleType = "role_type"
        case company, colour, order
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case planning
    }
}

// MARK: - Planning
struct Planning: Codable {
    let id: Int?
    let mission, vision: String?
    let type, clientRoleID: Int?
    let year, quarter, createdAt, updatedAt: String?
    let deletedAt: String?
    let objective: [Objective]?
    
    enum CodingKeys: String, CodingKey {
        case id, mission, vision, type
        case clientRoleID = "client_role_id"
        case year, quarter
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case objective
    }
}
