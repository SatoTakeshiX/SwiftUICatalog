//
//  DrawEditor.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct DrawingView: View {
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

extension DrawingView {
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

struct DrawEditor_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
