//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ToggleView: View {
    @State private var isOn = false
    var body: some View {
        VStack {
            Toggle("switch isOn", isOn: $isOn)
            Text("\(isOn ? "On" : "Off")")
        }
    }
}
PlaygroundPage.current.setLiveView(ToggleView()
                                    .frame(width: 500, height: 200).padding())

//: [Next](@next)
