//
//  AppController.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import Combine
import UIKit

class AppController: UINavigationController {
    
    private lazy var repositoryListViewController: RepositoryListViewController = {
        let controller = RepositoryListViewController()
        controller.delegate = self
        return controller
    }()
    
    private let networkService = NetworkService()
    private var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([repositoryListViewController], animated: false)
    }
}

extension AppController: RepositoryListViewControllerDelegate {
    
    func repositoryListViewController(_ controller: RepositoryListViewController, didSelect repository: Repository) {
        let repositoryDetails = RepositoryDetailsViewController(repository: repository)
        pushViewController(repositoryDetails, animated: true)
    }
    
    func repositoryListViewController(_ controller: RepositoryListViewController, shouldSearchQuery query: String) {
        networkService.search(query: query)
            .sink(
                receiveCompletion: { print($0) },
                receiveValue: {
                    self.repositoryListViewController.update(repositories: $0.items.sorted(by: { $0.updatedAt > $1.updatedAt }))
                }
            )
            .store(in: &subscriptions)
    }
}
