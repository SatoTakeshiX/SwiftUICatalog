//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ParentView: View {
    @State var counter = 0
    var body: some View {
        HStack {
            ChildView(counter: $counter)
                .frame(width: .infinity)
        }
    }
}
struct ChildView: View {
    @Binding var counter: Int
    var body: some View {
        Button(action: {
            counter += 1
        }, label: {
            Text("\(counter)")
                .font(.title)
        })
        .border(Color.red)
    }
}

PlaygroundPage.current.setLiveView(ParentView()
                                    .frame(width: 200, height: 100).padding())


//: [Next](@next)
