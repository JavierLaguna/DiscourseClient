//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

enum CategoriesDataManagerError: Error {
    case unknown
}

protocol CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> ())
}
