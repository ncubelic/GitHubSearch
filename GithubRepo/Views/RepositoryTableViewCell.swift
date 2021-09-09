//
//  RepositoryTableViewCell.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    lazy var primaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        
        NSLayoutConstraint.activate([
            primaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            primaryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            primaryLabel.trailingAnchor.constraint(equalTo: secondaryLabel.leadingAnchor, constant: -5),
            secondaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            secondaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            secondaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
        ])
        
        primaryLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        secondaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
