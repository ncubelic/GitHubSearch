//
//  RepositoryDetailsViewController.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import UIKit

class RepositoryDetailsViewController: UITableViewController {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = repository.name
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "RepositoryTableViewCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.primaryLabel.text = "Repository name"
            cell.secondaryLabel.text = repository.name
        case 1:
            cell.primaryLabel.text = "Last update time"
            cell.secondaryLabel.text = DateFormatter.localizedString(from: repository.updatedAt, dateStyle: .medium, timeStyle: .medium)
        case 2:
            cell.primaryLabel.text = "Owner name"
            cell.secondaryLabel.text = repository.owner.login
        case 3:
            cell.primaryLabel.text = "Description"
            cell.secondaryLabel.text = repository.description
        default:
            break
        }
        
        return cell
    }
}
