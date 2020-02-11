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
                    NavigationLink(destination: ImageSample()) {
                        Text("Image")
                    }
                    NavigationLink(destination: ButtonSample()) {
                        Text("Button")
                    }
                    NavigationLink(destination: PathSample()) {
                        Text("Path")
                    }
                    NavigationLink(destination: RoundedRectangleSample()) {
                        Text("RoundedRectangle")
                    }
                    NavigationLink(destination: SpacerSample()) {
                        Text("Spacer")
                    }
                    NavigationLink(destination: NavigationLinkSample()) {
                        Text("NavigationView")
                    }
                    NavigationLink(destination: ScrollViewSample()) {
                        Text("ScrollView")
                    }
                    NavigationLink(destination: TextFieldSample()) {
                        Text("TextField")
                    }
                    
                }

                Section(header: Text("View Presentations")) {
                    NavigationLink(destination: AlertSample()) {
                        Text(".alert")
                    }
                    NavigationLink(destination: SheetSample()) {
                        Text(".sheet")
                    }
                    NavigationLink(destination: ActionSheetSample()) {
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
