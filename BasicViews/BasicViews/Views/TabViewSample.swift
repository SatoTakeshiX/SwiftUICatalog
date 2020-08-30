//
//  TabViewSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/08/30.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct TabViewSample: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
            Text("Settings Page")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .underline()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct TabViewSample_Previews: PreviewProvider {
    static var previews: some View {
        TabViewSample()
    }
}

struct ListView: View {
    var body: some View {
        NavigationView {
            Form {
                ForEach(0 ..< 10) { index in
                    
                    NavigationLink(
                        destination: Text("detail: \(index) cell"),
                        label: {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("\(index)")
                            }
                        })
                }
            }
            .navigationBarTitle("Tab")
        }
    }
}
