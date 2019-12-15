//
//  ResearchGeometry.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ResearchGeometry: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("GeometryReader Get Global Origin")
                GeometryRectangle(color: Color.pink)
                GeometryRectangle(color: Color.red)
                .offset(x: 10, y: 0)
                ZStack {
                    GeometryRectangle(color: Color.blue)
                        .offset(x: 30, y: 0)
                }.offset(x: 10, y: 0)
            }
        }
    }
}

struct GeometryRectangle: View {
    var color: Color
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 20)
                .fill(self.color)
                .overlay(
                    VStack {
                        Text("X: \(Int(geometry.frame(in: .global).origin.x)) Y: \(Int(geometry.frame(in: .global).origin.y)) width: \(Int(geometry.frame(in: .global).width)) height: \(Int(geometry.frame(in: .global).height))")
                            .foregroundColor(.white)
                        Text("size: \(geometry.size.debugDescription)")
                            .foregroundColor(.white)
                })


        }.frame(height: 100)
    }
}

struct ResearchGeometry_Previews: PreviewProvider {
    static var previews: some View {
        ResearchGeometry()
    }
}
