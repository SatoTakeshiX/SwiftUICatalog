//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

final class DataSource: ObservableObject {
  @Published var counter = 0
}

struct ParentView: View {
    @StateObject var dataSource = DataSource()
    var body: some View {
        ChildView(dataSource: dataSource)
    }
}

struct ChildView: View {
    @ObservedObject var dataSource: DataSource
    var body: some View {
        VStack {
            Button("increment counter") {
                dataSource.counter += 1
            }
            Text("count： \(dataSource.counter)")
        }
    }
}

PlaygroundPage.current.setLiveView(ParentView()
                                    .frame(width: 500, height: 200).padding())


//: [Next](@next)
