//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    func fetchAllTopics(nextPage: String?, completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest(nextPage: nextPage)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        let request = CategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        let request = UsersRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        let request = UserDetailRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func updateNameUser(username: String, name: String, completion: @escaping (Result<UpdateNameUserResponse?, Error>) -> ()) {
        let request = UpdateNameUserRequest(username: username, name: name)
        session.send(request: request) { result in
            completion(result)
        }
    }
}
