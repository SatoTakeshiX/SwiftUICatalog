//
//  ContentView.swift
//  DataFlowSample
//
//  Created by satoutakeshi on 2020/09/17.
//

import SwiftUI

class DataSource: ObservableObject {
  @Published var counter = 0
}

struct ParentView: View {
    var body: some View {
        ChildView()
    }
}

struct ChildView: View {
    var body: some View {
        GrandChildView()
    }
}

struct GrandChildView: View {
    @EnvironmentObject var dataSource: DataSource
    var body: some View {
        Text("\(dataSource.counter)")
    }
}

struct DataFlowSampleApp_Previews: PreviewProvider {
    @StateObject static private var dataSource = DataSource()
    static var previews: some View {
        ParentView().environmentObject(dataSource)
    }
}
