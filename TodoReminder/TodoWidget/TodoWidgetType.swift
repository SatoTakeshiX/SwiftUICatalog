//
//  TodoWidgetType.swift
//  TodoWidgetExtension
//
//  Created by satoutakeshi on 2020/10/04.
//

import SwiftUI

protocol TodoWidgetType {
    func makePriorityColor(priority: Int) -> Color
    func makeURLScheme(id: UUID) -> URL?
}

extension TodoWidgetType {
    func makePriorityColor(priority: Int) -> Color {
        switch priority {
            case 0:
                return .green
            case 1:
                return .yellow
            case 2:
                return .red
            default:
                return .black
        }
    }

    func makeURLScheme(id: UUID) -> URL? {
        guard let url = URL(string: "todolist://detail") else {
            return nil
        }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "id", value: id.uuidString)]
        return urlComponents?.url
    }
}
