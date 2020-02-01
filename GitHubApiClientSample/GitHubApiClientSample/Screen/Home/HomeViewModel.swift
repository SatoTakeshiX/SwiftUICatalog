//
//  HomeViewModel.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/02/01.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    // MARK: - Inputs
    enum Inputs {
        case onEnter(text: String)
    }

    // MARK: - Outputs
    @Published private(set) var repositories: [Repository] = []
    @Published private(set) var inputText: String = ""
    @Published var isShowError = false
    @Published var isShowIndicator = false

    init(apiService: APIServiceType) {
        self.apiService = apiService
        bindInputs()
        bindOutputs()
    }

    func apply(inputs: Inputs) {
        switch inputs {
            case .onEnter(let query):
                onEnterSubject.send(query)
        }
    }

    // MARK: - Private
    private let apiService: APIServiceType
    private let onEnterSubject = PassthroughSubject<String, Never>()
    private let responseSubject = PassthroughSubject<SearchRepositoryResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private var cancellables: [AnyCancellable] = []

    private func bindInputs() {
        let responsePublisher = onEnterSubject
            .flatMap { [apiService] (query) in
                apiService.response(from: SearchRepositoryRequest(query: query))
                    .catch { [weak self] error -> Empty<SearchRepositoryResponse, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }

        let loadingStartPublisher = onEnterSubject
            .map { _ in true }
            .assign(to: \.isShowIndicator, on: self)

        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)

        cancellables += [
            responseStream,
            loadingStartPublisher
        ]
    }

    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map { $0.items }
            .sink(receiveValue: { (repositories) in
                self.repositories = repositories
                self.inputText = ""
                self.isShowIndicator = false
            })

        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isShowError, on: self)

        cancellables += [
            repositoriesStream,
            errorStream
        ]
    }
}
