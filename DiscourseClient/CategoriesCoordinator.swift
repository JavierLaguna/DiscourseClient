//
//  CategoriesCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa el tab del categories list
class CategoriesCoordinator: Coordinator {
    let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    override func start() {
        let categoriesViewModel = CategoriesViewModel()
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewController.title = NSLocalizedString("Categories", comment: "")
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {}
}
