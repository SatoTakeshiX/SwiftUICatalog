//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
struct ParentView: View {
    let title = "title"
    var body: some View {
        HStack {
            ChildView(color: .blue)
            ChildView(color: .yellow)
            ChildView(color: .red)
            Text(title)
        }
    }
}

struct ChildView: View {
    let color: Color
    var body: some View {
        Circle().foregroundColor(color)
    }
}

PlaygroundPage.current.setLiveView(ParentView()
                                    .frame(width: 600, height: 400).padding())

