//
//  Topic.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 24/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

typealias Topics = [Topic]

struct Topic: Codable {
    
    let id: Int
    let title: String
    let fancyTitle: String
    let slug: String
    let postsCount: Int
    let replyCount: Int
    let created_at: String
    let lastPostedAt: String
    let pinned: Bool
    let visible: Bool
    let closed: Bool
    let archived: Bool
    let views: Int
    let likeCount: Int
    let hasSummary: Bool
    let archetype: String
    let lastPosterUsername: String?
    let categoryId: Int
    let pinnedGlobally: Bool
    let posters: [Poster]
    
    enum CodingKeys: String, CodingKey {
        
        case id, title, slug, pinned, visible, closed, archived, views, archetype, posters
        case fancyTitle = "fancy_title"
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case created_at = "created_at"
        case lastPostedAt = "last_posted_at"
        case likeCount = "like_count"
        case hasSummary = "has_summary"
        case lastPosterUsername = "last_poster_username"
        case categoryId = "category_id"
        case pinnedGlobally = "pinned_globally"
    }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
    }
}

// MARK: Poster
extension Topic {
    
    struct Poster: Decodable {
        let extras: String?
        let description: String?
        let userId: Int
        let primaryGroupId: Int?
        
        enum CodingKeys: String, CodingKey {
            
            case extras, description
            case userId = "user_id"
            case primaryGroupId = "primary_group_id"
        }
    }
}
