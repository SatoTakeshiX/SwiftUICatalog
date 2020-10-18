//
//  GridSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/04.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
let threeColumns = [
    GridItem(spacing: 0),
    GridItem(spacing: 0),
    GridItem(spacing: 0)
]

@available(iOS 14.0, *)
let fixedThreeColumns = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100))
]

@available(iOS 14.0, *)
let flexibleColumns = [
    GridItem(.flexible(minimum: 100))
]

@available(iOS 14.0, *)
let adaptiveColumns = [
    GridItem(.adaptive(minimum: 100))
]


@available(iOS 14.0, *)
struct GridSample: View {
    let columns: [GridItem]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
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
            GridSample(columns: threeColumns)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample(columns: fixedThreeColumns)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample(columns: flexibleColumns)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample(columns: adaptiveColumns)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
        }
    }
}
