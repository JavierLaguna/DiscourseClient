//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un User
class UserDetailViewController: UIViewController {
    
    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelEmail: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = .black
        
        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal
        
        return userIDStackView
    }()
    
    lazy var usernameStackView: UIStackView = {
        let labelUsernameTitle = UILabel()
        labelUsernameTitle.text = NSLocalizedString("User username: ", comment: "")
        labelUsernameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let usernameStackView = UIStackView(arrangedSubviews: [labelUsernameTitle, labelUsername])
        usernameStackView.translatesAutoresizingMaskIntoConstraints = false
        usernameStackView.axis = .horizontal
        
        return usernameStackView
    }()
    
    lazy var userEmailStackView: UIStackView = {
        let userEmailLabel = UILabel()
        userEmailLabel.text = NSLocalizedString("User email: ", comment: "")
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let userEmailStackView = UIStackView(arrangedSubviews: [userEmailLabel, labelEmail])
        userEmailStackView.translatesAutoresizingMaskIntoConstraints = false
        userEmailStackView.axis = .horizontal
        
        return userEmailStackView
    }()
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(usernameStackView)
        NSLayoutConstraint.activate([
            usernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(userEmailStackView)
        NSLayoutConstraint.activate([
            userEmailStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userEmailStackView.topAnchor.constraint(equalTo: usernameStackView.bottomAnchor, constant: 8)
        ])
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    fileprivate func showErrorFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func updateUI() {
        labelUserID.text = viewModel.labelUserIDText
        labelUsername.text = viewModel.labelUserNameText
        labelEmail.text = viewModel.labelEmailText
        
    }

    fileprivate func showErrorModifingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error modifing user\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched() {
        updateUI()
    }
    
    func errorFetchingUserDetail() {
        showErrorFetchingUserDetailAlert()
    }
    
    func errorModifingUserDetail() {
        showErrorModifingUserDetailAlert()
    }
}
