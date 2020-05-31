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
    var searchText: String? {
        didSet {
            if searchText != oldValue {
                viewDelegate?.usersFetched()
            }
        }
    }
    var usersTopics: [UserCellViewModel] {
        guard let searchText = searchText, !searchText.isEmpty else { return usersViewModels }
        
        return usersViewModels.filter { user in
            return user.textLabelText?.contains(searchText) ?? false
        }
    }
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        fetchUsers()
    }
    
    func refreshUsers() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        usersDataManager.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let usersResp):
                guard let users = usersResp?.users else { return }
                self.usersViewModels = users.map { UserCellViewModel(user: $0) }
                
                self.viewDelegate?.usersFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingUsers()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return usersTopics.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < usersTopics.count else { return nil }
        return usersTopics[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < usersTopics.count else { return }
        coordinatorDelegate?.didSelect(user: usersTopics[indexPath.row].user)
    }
}
