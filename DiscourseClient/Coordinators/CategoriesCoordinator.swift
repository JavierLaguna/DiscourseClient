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
    let categoriesDataManager: CategoriesDataManager

    init(presenter: UINavigationController, categoriesDataManager: CategoriesDataManager) {
        self.presenter = presenter
        self.categoriesDataManager = categoriesDataManager
    }

    override func start() {
        let categoriesViewModel = CategoriesViewModel(categoriesDataManager: categoriesDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewController.title = NSLocalizedString("Categories", comment: "")
       
        categoriesViewModel.viewDelegate = categoriesViewController
        categoriesViewModel.coordinatorDelegate = self
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {}
}

extension CategoriesCoordinator: CategoriesCoordinatorDelegate {
    
}
