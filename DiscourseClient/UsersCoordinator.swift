//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?

    init(presenter: UINavigationController, usersDataManager: UsersDataManager,
         userDetailDataManager: UserDetailDataManager) {

        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }

    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }

    override func finish() {}
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    func didSelect(user: User) {
//        let topicDetailViewModel = TopicDetailViewModel(topicID: topic.id, topicDetailDataManager: topicDetailDataManager)
//        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
//        topicDetailViewModel.coordinatorDelegate = self
//        topicDetailViewModel.viewDelegate = topicDetailViewController
//        presenter.pushViewController(topicDetailViewController, animated: true)
    }
}

//extension usersCoordinator: TopicDetailCoordinatorDelegate {
//    func topicDetailBackButtonTapped() {
//        presenter.popViewController(animated: true)
//    }
//
//    func topicDeleted() {
//        presenter.popViewController(animated: true)
//        usersViewModel?.refreshusers()
//    }
//}
