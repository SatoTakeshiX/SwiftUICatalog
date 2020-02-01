//
//  MockAPIService.swift
//  GitHubApiClientSampleTests
//
//  Created by satoutakeshi on 2020/02/01.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Foundation
import Combine
@testable import GitHubApiClientSample

final class MockAPIService: APIServiceType {
    var stubs: [Any] = []

    typealias Request = APIRequestType

    func stub<Request>(for type: Request.Type, response: @escaping ((Request) -> AnyPublisher<Request.Response, APIServiceError>)) where Request: APIRequestType {
        stubs.append(response)
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {

        let response = stubs.compactMap { stub -> AnyPublisher<Request.Response, APIServiceError>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.Response, APIServiceError>)
            return stub?(request)
        }.last

        return response ?? Empty<Request.Response, APIServiceError>()
            .eraseToAnyPublisher()
    }
}
