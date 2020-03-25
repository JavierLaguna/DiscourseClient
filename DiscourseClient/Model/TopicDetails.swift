//
//  TopicDetails.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 24/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct TopicDetails: Codable {
    
    let canEdit: Bool?
    let canDelete: Bool?
    let canCreatePost: Bool?
    let canReplyAsNewTopic: Bool
    let canFlagTopic: Bool
    
    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canCreatePost = "can_create_post"
        case canReplyAsNewTopic = "can_reply_as_new_topic"
        case canFlagTopic = "can_flag_topic"
    }
    
}
