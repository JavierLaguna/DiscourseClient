//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak private var lastPosterImage: UIImageView!
    @IBOutlet weak private var postTitleLabel: UILabel!
    @IBOutlet weak private var postCountLabel: UILabel!
    @IBOutlet weak private var posterCountLabel: UILabel!
    @IBOutlet weak private var lastPostLabel: UILabel!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            postTitleLabel.text = viewModel.textLabelText
            postCountLabel.text = viewModel.postsCount
            posterCountLabel.text = viewModel.postersCount
            lastPostLabel.text = viewModel.lastPostDate
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        lastPosterImage.layer.cornerRadius = lastPosterImage.frame.height / 2
        postTitleLabel.font = UIFont.title
        
        postCountLabel.font = UIFont.cellDetail
        posterCountLabel.font = UIFont.cellDetail
        lastPostLabel.font = UIFont.cellDetailBold
    }
}
