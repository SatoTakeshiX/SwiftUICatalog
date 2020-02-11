//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct APIError: Error {
    var description: String
}

let cancelable = URLSession.shared.dataTaskPublisher(for:
    URL(string: "https://api.github.com/search/repositories?q=swiftui")!)
    .tryMap { (data, response) -> Data in
        guard let response = response as? HTTPURLResponse else {
            throw APIError(description: "http response not found")
        }
        guard (200..<300).contains(response.statusCode) else {
            throw APIError(description: "status code is bad")
        }
        return data
    }
    .mapError({ (error) -> APIError in
        if let error = error as? APIError {
            return error
        } else {
            return APIError(description: error.localizedDescription)
        }
    })
    .sink(receiveCompletion: { completion in
        switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                print("finished")
        }
    }, receiveValue: { data in
        print(String(data: data, encoding: .utf8) ?? "")
    })

//: [Next](@next)
