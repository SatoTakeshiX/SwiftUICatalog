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
                        let uniq = data.points.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
                        if uniq.count == 1 {
                            path.addArc(center: data.points[0], radius: 1, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360), clockwise: true)
                        } else {
                            path.addLines(data.points)
                        }
                    }
                    .stroke(data.color, lineWidth: 10)
                }
                
                // ドラッグ中の描画。指を離したらここの描画は消えるがDrawPathViewが上書きするので見た目は問題ない
                Path { path in

                    // 重複を排除
                    let uniq = tmpDrawPoints.points.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
                    // 重複排除して個数が一つだったら円を描く
                    if uniq.count == 1 {
                        path.addArc(center: tmpDrawPoints.points[0], radius: 1, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360), clockwise: true)
                    } else {
                        path.addLines(tmpDrawPoints.points)
                    }
                }
                .stroke(tmpDrawPoints.color, lineWidth: 10)
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
                    .sequenced(before: TapGesture().onEnded {})
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
