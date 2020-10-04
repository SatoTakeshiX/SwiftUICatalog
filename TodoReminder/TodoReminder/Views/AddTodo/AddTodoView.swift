//
//  AddTodoView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct AddTodoView: View {
    @State var newTodo: TodoListItem = TodoListItem(startDate: Date(), note: "", priority: .low, title: "")
    @Binding var isShow: Bool
    var body: some View {
       NavigationView {
            Form {
                Section(header: Text("タイトル")) {
                    TextField("例：ミーティング", text: $newTodo.title)
                }
                Section(header: Text("優先度")) {
                    Picker("優先度", selection: $newTodo.priority) {
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
                    DatePicker("", selection: $newTodo.startDate)
                }
                Section(header: Text("メモ")) {
                    TextEditor(text: $newTodo.note)
                        .foregroundColor(.black)
                        .frame(height: 200)
                }
            }
            .navigationTitle("何をしますか？")
            .navigationBarItems(trailing: Button(action: {
                let todoStore = TodoListStore()
                do {

                    try todoStore.insert(item: newTodo)
                    isShow.toggle()
                } catch let error {
                    print(error.localizedDescription)
                }
            }, label: {
                Text("決定")
            }))
       }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(isShow: .constant(true))
    }
}
