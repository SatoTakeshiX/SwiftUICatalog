//
//  TodoListViewModel.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

final class TodoListViewModel: ObservableObject {

    struct WidgetContent {
        let todoList: TodoListData
        let isShow: Bool = false
    }

    enum Inputs {
        case onAppear
        case onDismissAddTodo
        case openFromWidget(url: URL)
    }
    @Published var todoList: [TodoListData] = []
    @Published var widgetContent: WidgetContent?

    private let todoStore = TodoListStore()
    func apply(inputs: Inputs) {
        switch inputs {
            case .onAppear:
                updateTodo()
            case .onDismissAddTodo:
                updateTodo()
            case .openFromWidget(let url):


                break
        }
    }


    /// WidgetのURLSchemeからidを取得する
    /// - Parameter url: WidgetからのDeepLink URL. todolist://detail?id=xxxxxx.
    /// - Returns: id
    func getWidgetTodoId(from url: URL) -> String? {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        guard urlComponents.scheme == "todolist" else {
            return nil
        }
        guard urlComponents.host == "detail" else {
            return nil
        }
        if urlComponents.queryItems?.first?.name == "id" {
            return urlComponents.queryItems?.first?.value
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
}
