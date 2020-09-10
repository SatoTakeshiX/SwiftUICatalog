//
//  LinkSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/09/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LinkSample: View {
    @Environment(\.openURL) private var openURL
    let googleURL = URL(string: "https://google.com")!
    var body: some View {
        List {
            Link("google", destination: googleURL)
            Link(destination: googleURL) {
                Label("google", systemImage: "link")
            }
            Button(action: {
                openURL(googleURL)
            }, label: {
                Text("google with button")
            })
        }
    }
}

@available(iOS 14.0, *)
struct LinkSample_Previews: PreviewProvider {
    static var previews: some View {
        LinkSample()
    }
}
