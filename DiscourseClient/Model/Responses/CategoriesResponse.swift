//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// DOC Puedes echar un vistazo en https://docs.discourse.org

struct CategoriesResponse: Decodable {
    let categories: Categories
    
    enum CodingKeys: String, CodingKey {
        case categoriesRoot = "category_list"
        case categories
    }

    /*
     Buena forma de acceder al objeto anidado. ¡Me gusta! 😍
     */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rootCategories = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .categoriesRoot)
        
        categories = try rootCategories.decode(Categories.self, forKey: .categories)
    }
}


