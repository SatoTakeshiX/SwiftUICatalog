//
//  ContentView.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct FigureOutOfSize: View {
    var body: some View {
        GeometryReader { geometry in
            Text("geometry: \(geometry.size.debugDescription)")
        }
    }
}

struct CoodinateSpace: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.pink)
                    .overlay(VStack {
                        Text("X: \(geometry.frame(in: .global).origin.x) Y: \(geometry.frame(in: .global).origin.y) width: \(geometry.frame(in: .global).width) height: \(geometry.frame(in: .global).height)")
                            .foregroundColor(.white)

                    }.padding())
            }
            .frame(height: 200)
            Spacer()
        }
    }
}

struct CoodinateSpace2: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.pink)
                    .overlay(
                        Group {
                            VStack(alignment: .leading) {
                                Text("global frame")
                                Text("X: \(geometry.frame(in: .global).origin.x)")
                                Text("Y: \(geometry.frame(in: .global).origin.y)")
                                Text("width: \(geometry.frame(in: .global).width)")
                                Text("height: \(geometry.frame(in: .global).height)")
                                Text("local frame")
                                Text("X: \(geometry.frame(in: .local).origin.x)")
                                Text("Y: \(geometry.frame(in: .local).origin.y)")
                                Text("width: \(geometry.frame(in: .local).width)")
                                Text("height: \(geometry.frame(in: .local).height)")
                            }
                            VStack(alignment: .leading) {
                                Text("size")
                                Text("size: \(geometry.size.debugDescription)")
                                    .fontWeight(.medium)
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                )
            }
                .frame(height: 300)//GeometryReaderの大きさを指定する
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FigureOutOfSize()
            CoodinateSpace()
        }

    }
}
