//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UserCellViewModel {
    static let imageSize = 100
    
    let user: User
    var textLabelText: String?
    var imageUrl: URL?
    
    init(user: User) {
        self.user = user
        self.textLabelText = user.name ?? user.username
        
        let avatarUrl: String = user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(UserCellViewModel.imageSize)")
        self.imageUrl = URL(string: "\(apiURL)\(avatarUrl)")
    }
}
