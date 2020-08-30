//
//  AddTodoView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct AddTodoView: View {
    @State var newTodo: TodoListData = TodoListData(deadline: Date(), note: "", priority: 0, title: "")
    @State var priority: Int = 0
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
                            .tag(0)
                        Text("中")
                            .tag(1)
                        Text("高")
                            .tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("締め切り")) {
                    DatePicker("", selection: $newTodo.deadline)
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
