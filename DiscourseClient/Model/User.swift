//
//  User.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

typealias Users = [User]

struct User: Codable {
    
    let id: Int
    let username: String
    let name: String?
    let avatarTemplate: String
    let email: String?
    let canEdit: Bool?
    let canEditUsername: Bool?
    let canEditEmail: Bool?
    let canEditName: Bool?
    let ignored: Bool?
    let muted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userKey = "user"
        
        case id, username, name, email, ignored, muted
        case avatarTemplate = "avatar_template"
        case canEdit = "can_edit"
        case canEditUsername = "can_edit_username"
        case canEditEmail = "can_edit_email"
        case canEditName = "can_edit_name"
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let rootUser = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .userKey) {
            container = rootUser
        }
        
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        avatarTemplate = try container.decode(String.self, forKey: .avatarTemplate)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        canEdit = try container.decodeIfPresent(Bool.self, forKey: .canEdit)
        canEditUsername = try container.decodeIfPresent(Bool.self, forKey: .canEditUsername)
        canEditEmail = try container.decodeIfPresent(Bool.self, forKey: .canEditEmail)
        canEditName = try container.decodeIfPresent(Bool.self, forKey: .canEditName)
        ignored = try container.decodeIfPresent(Bool.self, forKey: .ignored)
        muted = try container.decodeIfPresent(Bool.self, forKey: .muted)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
    }
}
