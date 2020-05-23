//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: TopicPinnedCell.nibName, bundle: nil), forCellReuseIdentifier: TopicPinnedCell.defaultReuseIdentifier)
        table.register(UINib(nibName: TopicCell.nibName, bundle: nil), forCellReuseIdentifier: TopicCell.defaultReuseIdentifier)
        return table
    }()
    
    lazy var floatingButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icoNew")?.withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusButtonTapped)))
        
        return imageView
    }()
    
    let viewModel: TopicsViewModel
    let defaultFloatingButtonBottomSpace: CGFloat = -12
    var floatingButtonBottomConstraint: NSLayoutConstraint?
    var lastVelocityYSign = 0
    var showFloatingButton: Bool = true {
        didSet {
            if showFloatingButton != oldValue {
                hideFloatingButton(showFloatingButton)
            }
        }
    }
    lazy var searchBar = UISearchBar()


    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(floatingButton)
        let bottomConstraint = floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: defaultFloatingButtonBottomSpace)
        floatingButtonBottomConstraint = bottomConstraint
        NSLayoutConstraint.activate([
            floatingButton.widthAnchor.constraint(equalToConstant: floatingButton.bounds.height),
            floatingButton.heightAnchor.constraint(equalToConstant: floatingButton.bounds.width),
            floatingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            bottomConstraint
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureSearchBar()
        viewModel.viewWasLoaded()
    }
    
    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
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
    
    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    private func hideFloatingButton(_ show: Bool) {
        let distanceToBottom = floatingButton.frame.maxY.distance(to: view.frame.maxY) + floatingButton.frame.height
        let bottomSpace: CGFloat = show ? defaultFloatingButtonBottomSpace : distanceToBottom

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.35, animations: { [weak self] in
                guard let self = self, let bottomConstraint = self.floatingButtonBottomConstraint else { return }

                bottomConstraint.constant = bottomSpace
                self.view.layoutIfNeeded()
            })
        }
    }
    
    private func searchTopics(by text: String?) {
        // TODO implement topic search
    }
}

extension TopicsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.defaultReuseIdentifier, for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicPostCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopicPinnedCell.defaultReuseIdentifier, for: indexPath) as? TopicPinnedCell {
            
            return cell
        }
        
        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign &&
            currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        
        showFloatingButton = lastVelocityYSign >= 0
    }
}

extension TopicsViewController: TopicsViewDelegate {
    
    func topicsFetched() {
        tableView.reloadData()
    }
    
    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}

// MARK: UISearchBarDelegate
extension TopicsViewController: UISearchBarDelegate {
    
    func cancelSearchFilter() {
        searchTopics(by: nil)
        searchBar.endEditing(true)
        configureNavigationBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTopics(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearchFilter()
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
