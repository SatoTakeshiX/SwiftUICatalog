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
    @Published var activeTodoId: UUID?

    private let todoStore = TodoListStore()
    func apply(inputs: Inputs) {
        switch inputs {
            case .onAppear:
                updateTodo()
            case .onDismissAddTodo:
                updateTodo()
            case .openFromWidget(let url):
                if let selectedId = getWidgetTodoItemID(from: url) {
                    activeTodoId = selectedId
                }
        }
    }

    /// WidgetのURLSchemeからidを取得する
    /// - Parameter url: WidgetからのDeepLink URL. todolist://detail?id=E621E1F8-C36C-495A-93FC-0C247A3E6E5F.
    /// - Returns: id
    func getWidgetTodoItemID(from url: URL) -> UUID? {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
              urlComponents.scheme == "todolist",
              urlComponents.host == "detail",
              urlComponents.queryItems?.first?.name == "id",
              let idValue = urlComponents.queryItems?.first?.value else {
            return nil
        }
        return UUID(uuidString: idValue)
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
