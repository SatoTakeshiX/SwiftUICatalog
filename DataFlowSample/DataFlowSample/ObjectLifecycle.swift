//
//  ObjectLifecycle.swift
//  DataFlowSample
//
//  Created by satoutakeshi on 2020/12/07.
//

import SwiftUI

struct StateObjectCounterView: View {
    @StateObject private var dataSource = DataSource()
    var body: some View {
        VStack {
            Button("increment counter") {
                dataSource.counter += 1
            }
            Text("StateObject count： \(dataSource.counter)")
                .font(.title)
        }
    }
}

struct ObservedObjcetCounterView: View {
    @ObservedObject private var dataSource = DataSource()
    var body: some View {
        VStack {
            Button("increment counter") {
                dataSource.counter += 1
            }
            Text("ObservedObject count： \(dataSource.counter)")
                .font(.title)
        }
    }
}

struct SwitchColorView: View {
    @State private var isDanger: Bool = false
    var body: some View {
        VStack {
            Button("Change the Color") {
                isDanger.toggle()
            }
            if isDanger {
                Circle().foregroundColor(.red)
                    .frame(width: 200, height: 200)
            } else {
                Circle().foregroundColor(.green)
                    .frame(width: 200, height: 200)
            }
            StateObjectCounterView()
            ObservedObjcetCounterView()
            Spacer()
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchColorView()
            .previewLayout(.fixed(width: 200, height: 400))
    }
}
