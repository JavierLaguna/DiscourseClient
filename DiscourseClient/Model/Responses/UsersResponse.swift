//
//  UsersResponse.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// DOC Puedes echar un vistazo en https://docs.discourse.org

struct UsersResponse: Decodable {
    let users: Users

    enum CodingKeys: String, CodingKey {
        case users = "directory_items"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        users = try container.decode(Users.self, forKey: .users)
    }
}
