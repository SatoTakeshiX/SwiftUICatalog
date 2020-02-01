//
//  HomeViewModelTests.swift
//  GitHubApiClientSampleTests
//
//  Created by satoutakeshi on 2020/02/01.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import XCTest
@testable import GitHubApiClientSample

class HomeViewModelTests: XCTestCase {

    func testOnEnter() {
    //    let viewModel = HomeViewModel(apiService: <#T##APIServiceType#>)

        let apiService = MockAPIService()
        apiService.stub(for: SearchRepositoryRequest.self) { _ in
            Result.Publisher(
                SearchRepositoryResponse(
                                    items: [
                    .init(id: 0,
                          name: "takeshi",
                          description: "brabrabara",
                          stargazersCount: 100,
                          language: "Swift", url: "https://example.com",
                          owner: Owner(id: 1,
                                       avatarUrl: "https://example.com/photo.png"))
                                    ]
                                )
            ).eraseToAnyPublisher()
        }

        let viewModel = HomeViewModel(apiService: apiService)
        viewModel.apply(inputs: .onEnter(text: "sss"))
        XCTAssertTrue(!viewModel.cardViewInputs.isEmpty)
    }

    func testOnError() {
        let apiService = MockAPIService()
        apiService.stub(for: SearchRepositoryRequest.self) { _ in
            Result.Publisher(
                APIServiceError.responseError
            ).eraseToAnyPublisher()
        }
        let viewModel = HomeViewModel(apiService: apiService)
        viewModel.apply(inputs: .onEnter(text: "sss"))
        XCTAssertTrue(viewModel.isShowError)
    }

    func testTappedErrorAlert() {
        let apiService = MockAPIService()
        apiService.stub(for: SearchRepositoryRequest.self) { _ in
            Result.Publisher(
                APIServiceError.responseError
            ).eraseToAnyPublisher()
        }
        let viewModel = HomeViewModel(apiService: apiService)
        viewModel.apply(inputs: .tappedErrorAlert)
        XCTAssertTrue(!viewModel.isShowError)
    }
}
