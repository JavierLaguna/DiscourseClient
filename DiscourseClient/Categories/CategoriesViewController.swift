//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController para representar el listado de categorías
class CategoriesViewController: UIViewController {
    let viewModel: CategoriesViewModel

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        let testLabel = UILabel()
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.text = "Get a list of categories"

        view.addSubview(testLabel)
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
