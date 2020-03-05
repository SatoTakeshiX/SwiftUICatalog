//
//  SearchRepositoryResponse.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/28.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    let items: [Repository]
}
