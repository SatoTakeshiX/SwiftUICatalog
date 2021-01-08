//
//  Repository.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/28.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Foundation

struct Repository: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    let htmlUrl: String
    let owner: Owner
}
