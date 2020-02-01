//
//  HomeViewModel.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/02/01.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel: ObservableObject {

    // MARK: - Inputs
    enum Inputs {
        case onEnter(text: String)
        case tappedErrorAlert
        case showRepository(urlString: String)
    }

    // MARK: - Outputs
    @Published private(set) var cardViewInputs: [CardView.Input] = []
    @Published var inputText: String = ""
    @Published var isShowError = false
    @Published var isLoading = false
    @Published var isShowSheet = false
    @Published var repositoryUrl: String = ""

    init(apiService: APIServiceType) {
        self.apiService = apiService
        bindInputs()
        bindOutputs()
    }

    func apply(inputs: Inputs) {
        switch inputs {
            case .onEnter(let inputText):
                onEnterSubject.send(inputText)
            case .tappedErrorAlert:
                tappedErrorAlertSubject.send(())
            case .showRepository(let urlString):
                repositoryUrl = urlString
                isShowSheet = true
        }
    }

    // MARK: - Private
    private let apiService: APIServiceType
    private let onEnterSubject = PassthroughSubject<String, Never>()
    private let tappedErrorAlertSubject = PassthroughSubject<Void, Never>()
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
            .assign(to: \.isLoading, on: self)

        let tappedErrorAlertPublisher = tappedErrorAlertSubject
            .map { _ in false }
            .assign(to: \.isShowError, on: self)

        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)

        cancellables += [
            responseStream,
            loadingStartPublisher,
            tappedErrorAlertPublisher
        ]
    }

    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map { $0.items }
            .sink(receiveValue: { (repositories) in
                self.cardViewInputs = self.convertInput(repositories: repositories)
                self.inputText = ""
                self.isLoading = false
            })

        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isShowError, on: self)

        cancellables += [
            repositoriesStream,
            errorStream
        ]
    }

    private func convertInput(repositories: [Repository]) -> [CardView.Input] {
        return repositories.compactMap { (repo) -> CardView.Input? in
            do {
                let data = try Data(contentsOf: URL(string: repo.owner.avatarUrl)!)
                let image = UIImage(data: data)!
                return CardView.Input(iconImage: image,
                                      title: repo.name,
                                      language: repo.language,
                                      star: repo.stargazersCount,
                                      description: repo.description,
                                      url: repo.htmlUrl)

            } catch {
                return nil
            }
        }
    }
}
