//
//  UIView+NibLoadableView.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 23/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
