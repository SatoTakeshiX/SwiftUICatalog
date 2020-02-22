//
//  Canvas.swift
//  DrawingApp
//
//  Created by satoutakeshi on 2020/02/22.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct Canvas: View {
    @State private var endedDrawPoints: [DrawPoints] = []
    @State private var tmpDrawPoints: DrawPoints = DrawPoints(points: [], color: .red)
    @State private  var startPoint: CGPoint = .zero
    @Binding var selectedColor: DrawType
    @Binding var canvasRect: CGRect

//    init(selectedColor: Binding<DrawType>, canvasRect: Binding<CGRect>) {
//        self.selectedColor = selectedColor
//        self.canvasRect = canvasRect
//    }


    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .overlay(
                        DrawPathView(drawPointsArray: self.endedDrawPoints)
                )
                    .border(Color.black, width: 2)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ (value) in
                                if self.startPoint != value.startLocation {
                                    self.tmpDrawPoints.points.append(value.location)
                                    self.tmpDrawPoints.color = self.selectedColor.color

                                }
                            })
                            .onEnded({ (value) in
                                self.startPoint = value.startLocation
                                self.endedDrawPoints.append(self.tmpDrawPoints)
                                self.tmpDrawPoints = DrawPoints(points: [], color: self.selectedColor.color)
                            })
                )
                    .onAppear {
                        self.canvasRect = geometry.frame(in: .local)
                }
                // ドラッグ中の描画。指を離したらここの描画は消えるがDrawPathViewが上書きするので見た目は問題ない
                Path { path in
                    path.addLines(self.tmpDrawPoints.points)
                }
                .stroke(self.tmpDrawPoints.color, lineWidth: 10)
            }
        }
    }
}
