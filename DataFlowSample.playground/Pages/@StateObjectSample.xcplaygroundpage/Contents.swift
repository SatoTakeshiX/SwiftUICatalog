//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

final class DataSource: ObservableObject {
  @Published var counter = 0
}

struct CounterView: View {
    @StateObject private var dataSource = DataSource()
    var body: some View {
        VStack {
            Button("increment counter") {
                dataSource.counter += 1
            }
            Text("count： \(dataSource.counter)")
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
            } else {
                Circle().foregroundColor(.green)
            }
            CounterView()
        }
    }
}
PlaygroundPage.current.setLiveView(SwitchColorView()
                                    .frame(width: 500, height: 200).padding())
//: [Next](@next)
