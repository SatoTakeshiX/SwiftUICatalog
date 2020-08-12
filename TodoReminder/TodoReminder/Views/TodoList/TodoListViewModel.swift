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
        case didTapDetailCell
    }
    @Published var todoList: [TodoListData] = []

    private let todoStore = TodoListStore()
    func apply(inputs: Inputs) {
        switch inputs {
            case .onAppear:
                updateTodo()
            case .onDismissAddTodo:
                updateTodo()
            case .didTapDetailCell:
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
