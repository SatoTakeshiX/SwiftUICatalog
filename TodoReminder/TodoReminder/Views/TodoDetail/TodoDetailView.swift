//
//  TodoDetailView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct TodoDetailView: View {
    @State var todo: TodoListItem
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                Text(todo.title)
            }
            Section(header: Text("優先度")) {
                Picker("優先度", selection: Binding.constant(todo.priority)) {
                    Text("低")
                        .tag(TodoPriority.low)
                    Text("中")
                        .tag(TodoPriority.medium)
                    Text("高")
                        .tag(TodoPriority.high)
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("締め切り")) {
                DatePicker("", selection: .constant(todo.startDate))
            }
            Section(header: Text("メモ")) {
                TextEditor(text: .constant(todo.note))
                    .foregroundColor(.black)
                    .frame(height: 200)
            }
        }
        .navigationTitle("詳細")
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailView(todo: TodoListItem(startDate: Date(), note: "アジェンダを事前に作成しておく", priority: .low, title: "開発MTG"))
    }
}
