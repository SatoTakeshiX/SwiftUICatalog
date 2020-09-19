//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

final class DataSource: ObservableObject {
  @Published var counter = 0
}

struct Counter: View {
    @StateObject var dataSource = DataSource()

    var body: some View {
        VStack {
            Button("カウンターを増やそう") {
                dataSource.counter += 1
            }

            Text("カウント数： \(dataSource.counter)")
        }
    }
}

struct SwitchColor: View {
    @State private var isDanger: Bool = false
    var body: some View {
        VStack {
            Button("色を切り替える") {
                isDanger.toggle()
            }
            if isDanger {
                Circle().foregroundColor(.red)
            } else {
                Circle().foregroundColor(.green)
            }
            Counter()
        }
    }
}
PlaygroundPage.current.setLiveView(SwitchColor()
                                    .frame(width: 500, height: 200).padding())
//: [Next](@next)
