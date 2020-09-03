//
//  GridSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/04.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct GridSample: View {
    let columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    let mim100Colums = [
        GridItem(.adaptive(minimum: 100))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: mim100Colums, spacing: 0) {
                ForEach(0 ..< 100) { _ in
                    Image("seal_\(Int.random(in: 1 ... 3))")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct GridSample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GridSample()
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample()
                .previewDevice(PreviewDevice(rawValue: "iPad8,1"))
        }
    }
}
