//
//  TodoReminderApp.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI

@main
struct TodoReminderApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NavigationLink(
                    destination: AddTodoView(),
                    label: {
                        Text("tapped!")
                    })
//                Button(action: {
//                    isShow.toggle()
//                }, label: {
//
//
//                })
            }
        }
    }
}
