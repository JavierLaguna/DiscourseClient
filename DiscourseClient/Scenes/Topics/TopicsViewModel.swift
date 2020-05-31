//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    var nextPage: String?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []
    var searchText: String? {
        didSet {
            if searchText != oldValue {
                viewDelegate?.topicsFetched()
            }
        }
    }
    var filteredTopics: [TopicCellViewModel] {
        guard let searchText = searchText, !searchText.isEmpty else { return topicViewModels }
        
        return topicViewModels.filter { topic in
            guard let topic = topic as? TopicPostCellViewModel else {
                return true
            }
            
            return topic.textLabelText?.contains(searchText) ?? false
        }
    }
    
    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }
    
    func viewWasLoaded() {
        refreshTopics()
    }
    
    func refreshTopics() {
        nextPage = nil
        topicViewModels = [TopicPinnedCellViewModel()]
        
        fetchAllTopics()
    }
    
    func fetchMoreTopics() {
        fetchAllTopics()
        nextPage = nil
    }
    
    private func fetchAllTopics() {
        topicsDataManager.fetchAllTopics(nextPage: nextPage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let topicsResp):
                self.nextPage = topicsResp?.nextPage
                
                guard let topics = topicsResp?.topics,
                    let users = topicsResp?.users else { return }
                
                let newTopics: [TopicCellViewModel] = topics.compactMap { topic in
                    guard let lastPoster = users.first(where: {$0.username == topic.lastPosterUsername}) else {
                        return nil
                    }
                    
                    return TopicPostCellViewModel(topic: topic, lastPoster: lastPoster)
                }
                
                self.topicViewModels.append(contentsOf: newTopics)
                self.viewDelegate?.topicsFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingTopics()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return filteredTopics.count
    }
    
    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < filteredTopics.count else { return nil }
        return filteredTopics[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < filteredTopics.count, let topicVM = filteredTopics[indexPath.row] as? TopicPostCellViewModel else {
            return
        }
        
        coordinatorDelegate?.didSelect(topic: topicVM.topic)
    }
    
    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }
    
    func newTopicWasCreated() {
        refreshTopics()
    }
}
