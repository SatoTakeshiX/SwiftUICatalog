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
                // todolist://detail?id=xxxxxx

                guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return
                }
                guard urlComponents.host == "todolist" else {
                    return
                }
                guard urlComponents.path == "detail" else {
                    return
                }
                if urlComponents.queryItems?.first?.name == "id" {
                    urlComponents.queryItems?.first?.value
                }

                break
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
