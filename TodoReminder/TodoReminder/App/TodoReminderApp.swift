//
//  TodoReminderApp.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import SwiftUI
import WidgetKit

@main
struct TodoReminderApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .onChange(of: scenePhase) { newScenePhase in
                    if newScenePhase == .active {
                        WidgetCenter.shared.reloadTimelines(ofKind: "TodoWidget")
                    }
                }
        }
    }
}
