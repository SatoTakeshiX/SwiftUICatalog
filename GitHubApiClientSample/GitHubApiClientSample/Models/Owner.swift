//
//  Owner.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/28.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Foundation

struct Owner: Decodable, Hashable, Identifiable {
    var id: Int
    var avatarUrl: String
}
