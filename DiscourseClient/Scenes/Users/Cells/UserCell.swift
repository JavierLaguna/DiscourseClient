//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 23/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    @IBOutlet weak private var avatarImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.delegate = self
            avatarImage.image = viewModel.avatarImage
            nameLabel.text = viewModel.textLabelText
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImage.image = nil
    }
    
    // MARK: Private Functions
    private func configureUI() {
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.layer.masksToBounds = true
        
        nameLabel.font = UIFont.cellDetail
    }
    
    private func showImage(_ image: UIImage?) {
        avatarImage.alpha = 0
        avatarImage.image = image
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.avatarImage.alpha = 1
        }
    }
}

// MARK: UserCellViewModelDelegate
extension UserCell: UserCellViewModelDelegate {
    
    func userImageFetched() {
        guard let image = viewModel?.avatarImage else { return }
        
        showImage(image)
    }
}
