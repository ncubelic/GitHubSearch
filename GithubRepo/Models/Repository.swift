//
//  Repository.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import Foundation

struct Repository: Codable {
    let id: UInt64
    let name: String
    let updatedAt: Date
    let owner: Owner
    let description: String?
}
