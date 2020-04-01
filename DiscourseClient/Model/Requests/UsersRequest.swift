//
//  UsersRequest.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersRequest: APIRequest {
    
    typealias Response = UsersResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    // ?period={period}&order={order}
    
    var parameters: [String : String] {
        return [
            "period":
        ]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
