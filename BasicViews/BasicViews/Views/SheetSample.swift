//
//  SheetSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct SheetSample: View {
    @State private var isShowSheet: Bool = false
    var body: some View {
        Button(action: {
            self.isShowSheet = true
        }) {
            Image(systemName: "photo.on.rectangle")
            .resizable()
                .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
        }
        .sheet(isPresented: $isShowSheet) {
            Button(action: {
                self.isShowSheet = false
            }) {
                Text("Dismiss")
            }
        }
    }
}

struct SheetSample_Previews: PreviewProvider {
    static var previews: some View {
        SheetSample()
    }
}
