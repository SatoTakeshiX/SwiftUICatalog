//
//  ListSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/10/17.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ListSample: View {
    var body: some View {
        List {
            Section(header: Text("Weather"), footer: Text("footer")) {
                HStack {
                    Image(systemName: "moon")
                    Text("moon")
                }
                HStack {
                    Image(systemName: "sun.max")
                    Text("sun")
                }
            }
            Section(header: HStack{
                Image(systemName: "hare")
                Text("Animal")
            }) {
                HStack {
                    Image(systemName: "hare")
                    Text("rabbit")
                }
            }
            Section {
                HStack {
                    Image(systemName: "gamecontroller")
                    Text("game")
                }
            }
        }
    }
}

struct ListSample_Previews: PreviewProvider {
    static var previews: some View {
        ListSample()
    }
}
