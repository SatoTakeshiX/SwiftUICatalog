//
//  ScrollRectangle.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ScrollRectangle: View {
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pink)
                        .overlay(
                            Text("Y: \(Int(geometry.frame(in: .global).origin.y))")
                            .foregroundColor(.white)
                            .fontWeight(.heavy))
                            .font(.largeTitle)
                }.frame(height: 100)
                Spacer()
            }
        }
    }
}

struct ScrollRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ScrollRectangle()
    }
}
