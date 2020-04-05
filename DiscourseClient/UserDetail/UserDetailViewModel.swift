//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    func userUpdated()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func errorFetchingUserDetail()
    func errorModifingUserDetail()
}

class UserDetailViewModel {
    var labelUserIDText: String?
    var labelUserNameText: String?
    var labelEmailText: String?
    var labelNameText: String?
    var canModifyName = false
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let username: String
    
    init(username: String, userDetailDataManager: UserDetailDataManager) {
        self.username = username
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        userDetailDataManager.fetchUser(username: username) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let userResp):
                guard let user = userResp?.user else { return }
                
                self.labelUserIDText = "\(user.id)"
                self.labelUserNameText = user.username
                self.labelEmailText = user.email
                self.labelNameText = user.name
                
                self.canModifyName = user.canEditName ?? false
                
                self.viewDelegate?.userDetailFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingUserDetail()
            }
        }
    }
    
    func modifyUser() {
        //        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] result in
        //            guard let self = self else { return}
        //
        //            switch result {
        //            case .success:
        //                self.coordinatorDelegate?.topicDeleted()
        //            case .failure(let error):
        //                Log.error(error)
        //                self.viewDelegate?.errorDeletingTopicDetail()
        //            }
        //        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }
}
