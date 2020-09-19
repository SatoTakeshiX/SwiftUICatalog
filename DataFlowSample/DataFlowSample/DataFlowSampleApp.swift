//
//  DataFlowSampleApp.swift
//  DataFlowSample
//
//  Created by satoutakeshi on 2020/09/17.
//

import SwiftUI

@main
struct DataFlowSampleApp: App {
    @StateObject private var dataSource = DataSource()
    var body: some Scene {
        WindowGroup {
            StorageSampleView()
        }
    }
}
