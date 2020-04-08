//
//  UserDetailResponse.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// Puedes echar un vistazo en https://docs.discourse.org

struct UserDetailResponse: Decodable {
    let user: User
    
    init(from decoder: Decoder) throws {
        let rootObject = try decoder.singleValueContainer()
        user = try rootObject.decode(User.self)
    }
}
