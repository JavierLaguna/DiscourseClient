//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    let topic: Topic
    var textLabelText: String?
    var postsCount: String?
    var postersCount: String?
    var lastPostDate: String?
    
    init(topic: Topic) {
        self.topic = topic
        self.textLabelText = topic.title
        self.postsCount = "\(topic.postsCount)"
        self.postersCount = "\(topic.posters.count)"
        self.lastPostDate = ""
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let lastPostDate = formatter.date(from: topic.lastPostedAt) {
            formatter.dateFormat = "MMM d"
            self.lastPostDate = formatter.string(from: lastPostDate).capitalized
        }
        
//        if let avatarURL = viewModel.imageUrl {
//                       DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//                           guard let data = try? Data(contentsOf: avatarURL),
//                               let image = UIImage(data: data) else { return }
//
//                           DispatchQueue.main.async {
//                               self?.avatarImage.image = image
//                           }
//                       }
//                   }
    }
}
