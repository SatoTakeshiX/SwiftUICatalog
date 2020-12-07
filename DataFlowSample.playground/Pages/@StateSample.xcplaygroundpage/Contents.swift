//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ParentView: View {
    @State private var counter = 0
    var body: some View {
        Button(action: {
            counter += 1
        }, label: {
            Text("counter is \(counter)")
        })
    }
}

PlaygroundPage.current.setLiveView(ParentView()
                                    .frame(width: 200, height: 100).padding())


//: [Next](@next)
