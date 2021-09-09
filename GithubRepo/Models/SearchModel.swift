//
//  SearchModel.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import Foundation

struct SearchModel: Codable {
    let totalCount: Int
    let items: [Repository]
}
