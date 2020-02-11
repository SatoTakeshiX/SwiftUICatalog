//
//  ScrollViewSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ScrollViewSample: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        FixedSizeRectangle(color: .red)
                        FixedSizeRectangle(color: .red)
                        FixedSizeRectangle(color: .red)
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        FixedSizeRectangle(color: .yellow)
                        FixedSizeRectangle(color: .yellow)
                        FixedSizeRectangle(color: .yellow)
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        FixedSizeRectangle(color: .blue)
                        FixedSizeRectangle(color: .blue)
                        FixedSizeRectangle(color: .blue)
                    }
                }
            }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        }
    }
}

struct FixedSizeRectangle: View {
    var color: Color
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 100)
            .foregroundColor(color)
        .cornerRadius(20)
    }
}

struct ScrollViewSample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewSample()
    }
}
