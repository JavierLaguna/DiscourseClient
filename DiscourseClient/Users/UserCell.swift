//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            nameLabel?.text = viewModel.textLabelText
            
            if let avatarURL = viewModel.imageUrl {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let data = try? Data(contentsOf: avatarURL),
                        let image = UIImage(data: data) else { return }
                    
                    DispatchQueue.main.async {
                        self?.avatarImage.image = image
                    }
                }
            }
        }
    }
}
