//
//  TodoDetailView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct TodoDetailView: View {
    @State var todo: TodoListData
    var body: some View {
        //NavigationView {
            Form {
                Section(header: Text("Title")) {
                    Text(todo.title)
                }
                Section(header: Text("優先度")) {
                    Picker("優先度", selection: Binding.constant(todo.priority)) {
                        Text("低")
                            .tag(0)
                        Text("中")
                            .tag(1)
                        Text("高")
                            .tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("締め切り")) {
                    DatePicker("", selection: .constant(todo.deadline))
                }
                Section(header: Text("メモ")) {
                    TextEditor(text: .constant(todo.note))
                        .foregroundColor(.black)
                        .frame(height: 200)
                }
            }
            .navigationTitle("詳細")
       // }
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailView(todo: TodoListData(deadline: Date(), note: "iiiiii", priority: 0, title: "jijiji"))
    }
}
