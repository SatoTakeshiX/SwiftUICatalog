//
//  TodoListView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct TodoListView: View {
    @State var isShow = false
    @StateObject var viewModel = TodoListViewModel()
    var body: some View {
        NavigationView {

            /// https://www.donnywals.com/handling-deeplinks-in-ios-14-with-onopenurl/
            /// この書き方が必要
            List(viewModel.todoList) { todoItem in
                NavigationLink(
                    destination: TodoDetailView(todo: todoItem)) {
                    Text("\(todoItem.title)")


                }

                
//                ForEach(viewModel.todoList) { todo in
//                    NavigationLink(
//                        destination: TodoDetailView(todo: todo)) {
//                        HStack {
//                            if todo.priority == 0 {
//                                Circle()
//                                    .fill(Color.green)
//                                    .frame(width: 40)
//                            } else if todo.priority == 1 {
//                                Circle()
//                                    .fill(Color.yellow)
//                                    .frame(width: 40)
//                            } else if todo.priority == 2 {
//                                Circle()
//                                    .fill(Color.red)
//                                    .frame(width: 40)
//                            }
//                            VStack(alignment: .leading) {
//                                Text("\(todo.title)")
//                                    .font(.title)
//                                Text(todo.startDate, style: .date)
//                                    .font(.subheadline)
//                                Text(todo.startDate, style: .time)
//                                    .font(.subheadline)
//                            }
//                        }
//                    }
//                }
            }
            .navigationTitle("TodoList")
            .navigationBarItems(trailing: Button(action: {
                isShow.toggle()
            }, label: {
                Text("追加")
            }))
        }
        .onAppear(perform: {
            viewModel.apply(inputs: .onAppear)
        })

        .sheet(isPresented: $isShow, onDismiss: {
            viewModel.apply(inputs: .onDismissAddTodo)
        }, content: {
            AddTodoView(isShow: $isShow)
        })
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
