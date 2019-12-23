//
//  DrawEditor.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

enum DrawType {
    case red
    case clear
    case black

    var color: Color {
        switch self {
            case .red:
                return Color.red
            case .clear:
                return Color.white
            case .black:
                return Color.black
        }
    }
}

struct DrawPoints: Identifiable {
    var points: [CGPoint]
    var color: Color
    var id = UUID()
}

struct DrawPathView: View {
    var drawPointsArray: [DrawPoints]
    init(drawPointsArray: [DrawPoints]) {
        self.drawPointsArray = drawPointsArray
    }
    var body: some View {
        ZStack {
            ForEach(drawPointsArray) { data in
                Path { path in
                    path.addLines(data.points)
                }
                .stroke(data.color, lineWidth: 10)
            }
        }
    }
}

struct DrawEditor: View {
    @State var tmpDrawPoints: DrawPoints = DrawPoints(points: [], color: .red)
    @State var endedDrawPoints: [DrawPoints] = []
    @State var startPoint: CGPoint = CGPoint.zero
    @State var selectedColor: DrawType = .red
    @State var canvasRect: CGRect = .zero

    var body: some View {
        VStack {
            Canvas(endedDrawPoints: $endedDrawPoints,
                   tmpDrawPoints: $tmpDrawPoints,
                   startPoint: $startPoint,
                   selectedColor: $selectedColor,
                   canvasRect: $canvasRect)
            HStack(spacing: 10) {
                Spacer()
                Button(action: {
                    self.selectedColor = .red

                }) { Text("赤")
                }
                .frame(width: 80, height: 100, alignment: .center)
                .background(Color.red)
                .cornerRadius(20)
                .foregroundColor(.white)
                Button(action: {
                    self.selectedColor = .clear
                }) { Text("消しゴム")
                }
                .frame(width: 80, height: 100, alignment: .center)
                .background(Color.white)
                .cornerRadius(20)
                .foregroundColor(.red)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 4)
                )
                Button(action: {
                    let image = self.captureCanvas(canvasRect: self.canvasRect, endedDrawPoints: self.endedDrawPoints, tmpDrawPoints: self.tmpDrawPoints, startPoint: self.startPoint, selectedColor: self.selectedColor)
                    print(image)

                }) { Text("保存")
                }

                .frame(width: 80, height: 100, alignment: .center)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 4)
                )

                //.foregroundColor(.red)

                Spacer()
            }
            .frame(minWidth: 0.0, maxWidth: CGFloat.infinity)
            //.background(Color.gray)
        }
        // .edgesIgnoringSafeArea(.top)
    }
}

struct DrawEditor_Previews: PreviewProvider {
    static var previews: some View {
        DrawEditor()
    }
}

extension UIView {
    var renderedImage: UIImage {
        // rect of capure
        let rect = self.bounds
        // create the context of bitmap
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        // get a image from current context bitmap
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImage
    }
}

extension DrawEditor {
    func captureCanvas(canvasRect: CGRect,
                       endedDrawPoints: [DrawPoints],
                       tmpDrawPoints: DrawPoints,
                       startPoint: CGPoint,
                       selectedColor: DrawType) -> UIImage {

        let window = UIWindow(frame: CGRect(origin: canvasRect.origin,
                                            size: canvasRect.size))
        let canvas =  Canvas(endedDrawPoints: .constant(endedDrawPoints),
                             tmpDrawPoints: .constant(tmpDrawPoints),
                             startPoint: .constant(startPoint),
                             selectedColor: .constant(selectedColor),
                             canvasRect: .constant(canvasRect))
        let hosting = UIHostingController(rootView: canvas.body)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.renderedImage
    }
}

struct Canvas: View {
    @Binding var endedDrawPoints: [DrawPoints]
    @Binding var tmpDrawPoints: DrawPoints
    @Binding var startPoint: CGPoint
    @Binding var selectedColor: DrawType
    @Binding var canvasRect: CGRect

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
                        DragGesture()
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
                        self.canvasRect = geometry.frame(in: .global)
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
