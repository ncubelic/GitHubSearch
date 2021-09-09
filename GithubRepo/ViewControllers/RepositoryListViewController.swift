//
//  RepositoryListViewController.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import UIKit

protocol RepositoryListViewControllerDelegate: AnyObject {
    func repositoryListViewController(_ controller: RepositoryListViewController, shouldSearchQuery query: String)
    func repositoryListViewController(_ controller: RepositoryListViewController, didSelect repository: Repository)
}

class RepositoryListViewController: UITableViewController, UISearchControllerDelegate {
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search"
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    weak var delegate: RepositoryListViewControllerDelegate?
    private var workItem: DispatchWorkItem?
    private let relativeDateTimeFormatter = RelativeDateTimeFormatter()
    
    private var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub"
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "RepositoryTableViewCell")
        tableView.register(RepositoryListHeader.self, forHeaderFooterViewReuseIdentifier: "RepositoryListHeader")
        navigationItem.searchController = searchController
    }
    
    func update(repositories: [Repository]) {
        self.repositories = repositories
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell") as? RepositoryTableViewCell else { return UITableViewCell() }
        cell.primaryLabel.text = repositories[indexPath.row].name
        cell.secondaryLabel.text = relativeDateTimeFormatter.localizedString(for: repositories[indexPath.row].updatedAt, relativeTo: Date())
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: "RepositoryListHeader")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.repositoryListViewController(self, didSelect: repositories[indexPath.row])
    }
}

extension RepositoryListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        workItem?.cancel()

        let workItem = DispatchWorkItem {
            self.executeSearch()
        }
        self.workItem = workItem

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: workItem)
    }
    
    private func executeSearch() {
        guard let queryString = searchController.searchBar.text else { return }
        guard !queryString.isEmpty else {
            update(repositories: [])
            return
        }
        delegate?.repositoryListViewController(self, shouldSearchQuery: queryString)
    }
}
