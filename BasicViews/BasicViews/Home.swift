//
//  Home.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Views")) {
                    NavigationLink(destination: TextSamples()) {
                        Text("Text")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("Image")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("Button")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("Path")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("RoundedRectangle")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("Spacer")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("NavigationView")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("ScrollView")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("TextField")
                    }
                    NavigationLink(destination: Text("sss")) {
                        Text("Text")
                    }
                }

                Section(header: Text("View Presentations")) {
                    NavigationLink(destination: Text("dd")) {
                        Text(".alert")
                    }
                    NavigationLink(destination: Text("dd")) {
                        Text(".sheet")
                    }
                    NavigationLink(destination: Text("dd")) {
                        Text(".actionSheet")
                    }
                }
            }
            .navigationBarTitle("Basic Views", displayMode: .inline)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
