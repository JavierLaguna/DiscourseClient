//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de users
class UsersViewController: UIViewController {
    
    lazy private var flowLayout: UICollectionViewFlowLayout = {
        let numberOfColumns: Int = 3
        let sectionInset: CGFloat = 24
        let minimumInteritemSpacing: CGFloat = 34
        let minimumLineSpacing: CGFloat = 19
        let cellHeight: CGFloat = 123
        
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = (UIScreen.main.bounds.width - sectionInset * 2 - minimumInteritemSpacing * (CGFloat(numberOfColumns) - 1)) / CGFloat(numberOfColumns)
        layout.itemSize = CGSize(width: width, height: cellHeight)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        return layout
    }()
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: UserCell.nibName, bundle: nil), forCellWithReuseIdentifier: UserCell.defaultReuseIdentifier)
        return collectionView
    }()
    
    lazy private var searchBar = UISearchBar()
    private var refreshControl = UIRefreshControl()
    private let viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureSearchBar()
        configureRefreshControl()
        viewModel.viewWasLoaded()
    }
    
    @objc func plusButtonTapped() {
        // TODO implement
    }
    
    @objc private func enableSearchBar() {
        navigationItem.leftBarButtonItems = nil
        navigationItem.rightBarButtonItems = nil
        searchBar.text = ""
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.tintColor = .orangeKCPumpkin
        
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = .blackKC
        searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    private func configureNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView = nil
        
        let addIcon = UIImage(named: "icoAdd")?.withRenderingMode(.alwaysTemplate)
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(plusButtonTapped))
        leftBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let serachIcon = UIImage(named: "icoSearch")?.withRenderingMode(.alwaysTemplate)
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: serachIcon, style: .plain, target: self, action: #selector(enableSearchBar))
        rightBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchUsers), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    fileprivate func showErrorFetchingUsersAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching users\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    @objc private func fetchUsers() {
        viewModel.refreshUsers()
    }
    
    private func searchUsers(by text: String?) {
        // TODO implement topic search
    }
}

extension UsersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.defaultReuseIdentifier, for: indexPath) as? UserCell, let cellViewModel = viewModel.viewModel(at: indexPath) else {
            fatalError()
        }
        
        cell.viewModel = cellViewModel
        return cell
    }
}

extension UsersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UsersViewDelegate {
    
    func usersFetched() {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func errorFetchingUsers() {
        showErrorFetchingUsersAlert()
    }
}

// MARK: UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
    
    func cancelSearchFilter() {
        searchUsers(by: nil)
        searchBar.endEditing(true)
        configureNavigationBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchUsers(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearchFilter()
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
