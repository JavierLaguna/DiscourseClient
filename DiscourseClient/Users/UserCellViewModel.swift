//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    
    init(user: User) {
        self.user = user
//        self.textLabelText = user.title
    }
}
