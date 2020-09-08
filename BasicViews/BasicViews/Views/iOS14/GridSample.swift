//
//  GridSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/04.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
let threeColums = [
    GridItem(spacing: 0),
    GridItem(spacing: 0),
    GridItem(spacing: 0)
]

@available(iOS 14.0, *)
let fixedThreeColums = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100))
]

@available(iOS 14.0, *)
let flexibleColums = [
    GridItem(.flexible(minimum: 100))
]

@available(iOS 14.0, *)
let adaptiveColums = [
    GridItem(.adaptive(minimum: 100))
]


@available(iOS 14.0, *)
struct GridSample: View {
    let colums: [GridItem]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 0) {
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
            GridSample(colums: threeColums)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample(colums: fixedThreeColums)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample(colums: flexibleColums)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            GridSample(colums: adaptiveColums)
                    .previewDevice(PreviewDevice(rawValue: "iPhone X"))
        }
    }
}
