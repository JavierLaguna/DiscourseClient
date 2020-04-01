//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

/// ViewModel que representa un listado de users
class UsersViewModel {
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    let usersDataManager: UsersDataManager
    var usersViewModels: [UserCellViewModel] = []
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        usersDataManager.fetchAllUsers { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let topicsResp):
                print()
//                guard let topics = topicsResp?.topics else { return }
//                self.topicViewModels = topics.map { TopicCellViewModel(topic: $0) }
//
//                self.viewDelegate?.topicsFetched()

            case .failure(let error):
                Log.error(error)
                print()
//                self.viewDelegate?.errorFetchingTopics()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return usersViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < usersViewModels.count else { return nil }
        return usersViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < usersViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: usersViewModels[indexPath.row].user)
    }
}
