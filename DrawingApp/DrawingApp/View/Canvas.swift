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
                    .stroke(data.color, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                }
                
                // ドラッグ中の描画。指を離したらここの描画は消えるがDrawPathViewが上書きするので見た目は問題ない
                Path { path in
                    path.addLines(tmpDrawPoints.points)
                }
                .stroke(tmpDrawPoints.color, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ (value) in
                        tmpDrawPoints.color = selectedColor.color
                        guard !tmpDrawPoints.points.isEmpty else {
                            tmpDrawPoints.points.append(value.location)
                            return
                        }

                        if let lastPoint = tmpDrawPoints.points.last,
                           filterDistance(startPoint: lastPoint, endPoint: value.location) {
                            tmpDrawPoints.points.append(value.location)
                        }
                    })
                    .onEnded({ (value) in
                        endedDrawPoints.append(tmpDrawPoints)
                        tmpDrawPoints = DrawPoints(points: [], color: selectedColor.color)
                    })
            )
        }
    }

    /// 座標の距離が近いかどうかを判定する。複数本の指をタップした場合もDragGestureはonChangedを呼ぶが、連続した線ではないのでフィルターをかける。
    /// - Parameters:
    ///   - startPoint: 開始座標
    ///   - endPoint: 終わりの座標
    /// - Returns: 距離が130以下ならtrue, それ以外ならfalse
    private func filterDistance(startPoint: CGPoint, endPoint: CGPoint) -> Bool {
        let distance = sqrt(pow(Double(startPoint.x) - Double(endPoint.x), 2) + pow(Double(startPoint.y) - Double(endPoint.y), 2))
        return distance <= 130
    }
}
