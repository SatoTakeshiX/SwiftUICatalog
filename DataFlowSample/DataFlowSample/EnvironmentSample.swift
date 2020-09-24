//
//  EnvironmentSample.swift
//  DataFlowSample
//
//  Created by satoutakeshi on 2020/09/21.
//

import SwiftUI

struct EnvironmentSample: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        if colorScheme == .dark {
            Text("dark mode")
        } else if colorScheme == .light {
            Text("light mode")
        } else {
            Text("")
        }
    }
}

struct EnvironmentSample_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentSample()
    }
}
