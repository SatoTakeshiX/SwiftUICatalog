//
//  MinMidMaxSpace.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct MinMidMaxSpace: View {
    var body: some View {
        VStack {
            Text("Global座標")
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 10) {
                    Text("Global座標")
                    HStack {
                        Text("minX: \(Int(geometry.frame(in: .global).minX))")
                        Spacer()
                        Text("midX: \(Int(geometry.frame(in: .global).midX))")
                        Spacer()
                        Text("maxX: \(Int(geometry.frame(in: .global).maxX))")
                    }
                    HStack {
                        Text("minY: \(Int(geometry.frame(in: .global).minY))")
                        Spacer()
                        Text("midY: \(Int(geometry.frame(in: .global).midY))")
                        Spacer()
                        Text("maxY: \(Int(geometry.frame(in: .global).maxY))")
                    }
                    Text("Local座標")
                    HStack {
                        Text("minX: \(Int(geometry.frame(in: .local).minX))")
                        Spacer()
                        Text("midX: \(Int(geometry.frame(in: .local).midX))")
                        Spacer()
                        Text("maxX: \(Int(geometry.frame(in: .local).maxX))")
                    }
                    HStack {
                        Text("minY: \(Int(geometry.frame(in: .local).minY))")
                        Spacer()
                        Text("midY: \(Int(geometry.frame(in: .local).midY))")
                        Spacer()
                        Text("maxY: \(Int(geometry.frame(in: .local).maxY))")
                    }
                    HStack {
                        Text("width: \(Int(geometry.size.width))")
                        Text("height: \(Int(geometry.size.height))")
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.pink)
            .foregroundColor(Color.white)
            Spacer()
        }
    }
}

struct MinMidMaxSpace_Previews: PreviewProvider {
    static var previews: some View {
        MinMidMaxSpace()
    }
}
