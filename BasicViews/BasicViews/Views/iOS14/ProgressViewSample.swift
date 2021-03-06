//
//  ProgressViewSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/09.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct ProgressViewSample: View {
    var body: some View {
        ScrollView {
            ProgressView("Downloading…")
                .padding()
            ProgressView("Downloading…", value: 30, total: 100)
                .padding()

        }
    }
}

@available(iOS 14.0, *)
struct ProgressViewSample_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewSample()
    }
}
