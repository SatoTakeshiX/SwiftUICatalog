//
//  AppSceneSampleApp.swift
//  AppSceneSample
//
//  Created by t-sato on 2020/09/12.
//

import SwiftUI

@main
struct MyApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView(colums: adaptiveColums)
                .onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .background:
                        print("do something when background")
                    case .inactive:
                        print("do something when inactive")
                    case .active:
                        print("do something when active")
                    @unknown default:
                        fatalError()
                    }
                }
        }
    }
}
