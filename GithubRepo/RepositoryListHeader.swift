//
//  RepositoryListHeader.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import UIKit

class RepositoryListHeader: UITableViewHeaderFooterView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var updatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Last update"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(updatedLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            updatedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            updatedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
