//
//  AddTodoView.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

struct AddTodoView: View {
    @State var title: String = ""
    @State var priorityType = 0
    @State var deadline = Date()
    @State var note: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("しなければいけないもの", text: $title)
                }
                Section(header: Text("優先度")) {
                    Picker("優先度", selection: $priorityType) {
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
                    DatePicker("", selection: $deadline)
                }
                Section(header: Text("メモ")) {
                    TextEditor(text: $note)
                        .foregroundColor(.black)
                        .frame(height: 200)
                }
            }
            .navigationTitle("何をしますか？")
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
