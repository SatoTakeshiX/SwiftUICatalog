//
//  TodoReminderApp.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

@main
struct TodoReminderApp: App {
    @State var isShow: Bool = false
    var body: some Scene {
        WindowGroup {
            TodoListView()
//            Button(action: {
//                isShow.toggle()
//            }, label: {
//                Text("tapped")
//            })
//            .onAppear(perform: {
//                print("onAppear")
//            })
//            .sheet(isPresented: $isShow, onDismiss: {
//                print("ssss")
//            }, content: {
//                VStack {
//                    Text("ddd")
//                    Button(action: {
//                        isShow.toggle()
//                    }, label: {
//                        Text("tapped")
//                    })
//                }
//
//            })
        }
    }
}
