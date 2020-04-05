//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// DataManager con las operaciones necesarias de este módulo
protocol UserDetailDataManager: class {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ())

}
