//
//  TodoListView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct TodoListView: View {
    @ObservedObject var viewModel = TodoListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todoList) { todo in
                    NavigationLink(
                        destination: TodoDetailView(todo: todo)) {
                        HStack {
                            if todo.priority == 0 {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 40)
                            } else if todo.priority == 1 {
                                Circle()
                                    .fill(Color.yellow)
                                    .frame(width: 40)
                            } else if todo.priority == 2 {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 40)
                            }
                            VStack(alignment: .leading) {
                                Text("\(todo.title ?? "")")
                                    .font(.title)
                                Text("\(todo.deadline?.description ?? "")")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("TodoList")
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
