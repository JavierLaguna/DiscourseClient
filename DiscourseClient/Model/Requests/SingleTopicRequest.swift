//
//  SingleTopicRequest.swift
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct SingleTopicRequest: APIRequest {
    
    typealias Response = SingleTopicResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: Method {
        fatalError("Need to implement this")
    }
    
    var path: String {
        fatalError("Need to implement this")
    }
    
    var parameters: [String : String] {
        fatalError("Need to implement this")
    }
    
    var body: [String : Any] {
        fatalError("Need to implement this")
    }
    
    var headers: [String : String] {
        fatalError("Need to implement this")
    }
}
