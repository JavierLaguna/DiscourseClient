//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa una categoría  en la lista
class CategoryCell: UITableViewCell {
    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
        }
    }
}
