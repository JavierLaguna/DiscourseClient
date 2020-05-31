//
//  UIView+ReusableView.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 23/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
