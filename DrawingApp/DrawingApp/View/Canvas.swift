//
//  Canvas.swift
//  DrawingApp
//
//  Created by satoutakeshi on 2020/02/22.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct Canvas: View {
    @Binding var endedDrawPoints: [DrawPoints]
    @State private var tmpDrawPoints: DrawPoints = DrawPoints(points: [], color: .red)
    @Binding var selectedColor: DrawColor
    @Binding var canvasRect: CGRect

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .border(Color.black, width: 2)
                    .onAppear {
                        canvasRect = geometry.frame(in: .local)
                    }

                ForEach(endedDrawPoints) { data in
                    Path { path in
                        path.addLines(data.points)
                    }
                    .stroke(data.color, lineWidth: 10)
                }
                
                // ドラッグ中の描画。指を離したらここの描画は消えるがDrawPathViewが上書きするので見た目は問題ない
                Path { path in
                    path.addLines(tmpDrawPoints.points)
                }
                .stroke(tmpDrawPoints.color, lineWidth: 10)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ (value) in
                        tmpDrawPoints.points.append(value.location)
                        tmpDrawPoints.color = selectedColor.color
                    })
                    .onEnded({ (value) in
                        endedDrawPoints.append(tmpDrawPoints)
                        tmpDrawPoints = DrawPoints(points: [], color: selectedColor.color)
                    })
            )
        }
    }
}
