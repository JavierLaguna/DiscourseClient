//
//  CategoryCellViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa una category en la lista
class CategoryCellViewModel {
    let category: Category
    var textLabelText: String?
    
    init(category: Category) {
        self.category = category
        self.textLabelText = category.name
    }
}
