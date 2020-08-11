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
        case addTodo
        case didTapDetailCell
    }
    @Published var todoList: [TodoListData] = [TodoListData(deadline: Date(), note: "jijiji", priority: 0, title: "todotodo")]

    func apply(inputs: Inputs) {
        switch inputs {
            case .onAppear:
                break
            case .addTodo:
                break
            case .didTapDetailCell:
                break
        }
    }
}
