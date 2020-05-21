//
//  TopicPinnedCell.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 21/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class TopicPinnedCell: UITableViewCell {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        containerView.layer.cornerRadius = 8
        titleLabel.font = .bigTitle
        subtitleLabel.font = .paragraph
    }
}
