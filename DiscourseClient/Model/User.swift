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
    let likesReceived: Int
    let likesGiven: Int
    let topicsEntered: Int
    let topicCount: Int
    let postCount: Int
    let postsRead: Int
    let daysVisited: Int
    let username: String
    let avatarTemplate: String
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case userKey = "user"
        
        case id, username, name
        case avatarTemplate = "avatar_template"
        case likesReceived = "likes_received"
        case likesGiven = "likes_given"
        case topicsEntered = "topics_entered"
        case topicCount = "topic_count"
        case postCount = "post_count"
        case postsRead = "posts_read"
        case daysVisited = "days_visited"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rootUser = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .userKey)
        
        id = try rootUser.decode(Int.self, forKey: .id)
        username = try rootUser.decode(String.self, forKey: .username)
        avatarTemplate = try rootUser.decode(String.self, forKey: .avatarTemplate)
        name = try rootUser.decodeIfPresent(String.self, forKey: .name)
        
        likesReceived = try container.decode(Int.self, forKey: .likesReceived)
        likesGiven = try container.decode(Int.self, forKey: .likesGiven)
        topicsEntered = try container.decode(Int.self, forKey: .topicsEntered)
        topicCount = try container.decode(Int.self, forKey: .topicCount)
        postCount = try container.decode(Int.self, forKey: .postCount)
        postsRead = try container.decode(Int.self, forKey: .postsRead)
        daysVisited = try container.decode(Int.self, forKey: .daysVisited)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
    }
}
