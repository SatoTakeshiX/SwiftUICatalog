//
//  TodoListViewModel.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

final class TodoListViewModel: ObservableObject {
    enum Inputs {
        case onAppear
        case onDismissAddTodo
        case openFromWidget(url: URL)
    }
    @Published var todoList: [TodoListItem] = []

    private let todoStore = TodoListStore()
    func apply(inputs: Inputs) {
        switch inputs {
            case .onAppear:
                updateTodo()
            case .onDismissAddTodo:
                updateTodo()
            case .openFromWidget(let url):
                if let id = getWidgetTodoItem(from: url) {
                    print(id)
                }
        }
    }

    /// WidgetのURLSchemeからidを取得する
    /// - Parameter url: WidgetからのDeepLink URL. todolist://detail?id=xxxxxx.
    /// - Returns: id
    func getWidgetTodoItem(from url: URL) -> UUID? {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        guard urlComponents.scheme == "todolist" else {
            return nil
        }
        guard urlComponents.host == "detail" else {
            return nil
        }
        guard urlComponents.queryItems?.first?.name == "id" else {
            return nil
        }
        if let idValue = urlComponents.queryItems?.first?.value {
            return UUID(uuidString: idValue)
        } else {
            return nil
        }
    }

    private func updateTodo() {
        do {
            let list = try todoStore.fetchAll()
            print("list count is \(list.count)")
            todoList = list
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func fechtTodoItem(by id: String) {
        
    }
}
