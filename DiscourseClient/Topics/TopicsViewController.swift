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
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        return table
    }()
    
    lazy var floatingButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icoNew"))
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
        viewModel.viewWasLoaded()
    }
    
    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
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
}

extension TopicsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
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
