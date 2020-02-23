//
//  DrawEditor.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct DrawingView: View {
    //@State var tmpDrawPoints: DrawPoints = DrawPoints(points: [], color: .red)
    @State var endedDrawPoints: [DrawPoints] = []
    @State var startPoint: CGPoint = CGPoint.zero
    @State var selectedColor: DrawType = .red
    @State var canvasRect: CGRect = .zero
    @ObservedObject var viewModel = DrawingViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Canvas(endedDrawPoints: self.$endedDrawPoints,
                //tmpDrawPoints: self.$tmpDrawPoints,
                startPoint: self.$startPoint,
                selectedColor: self.$selectedColor,
                canvasRect: self.$canvasRect)
                HStack(spacing: 10) {
                    Spacer()
                    Button(action: {
                        self.selectedColor = .red

                    }) {
                        Text("赤")
                        .frame(width: 80, height: 100, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                    }

                    Button(action: {
                        self.selectedColor = .clear
                    }) {
                        Text("消しゴム")
                        .frame(width: 80, height: 100, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .foregroundColor(.red)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 4)
                        )
                    }

                    Button(action: {
                        let captureImage = self.capture(rect: geometry.frame(in: .global))
                        self.viewModel.apply(inputs: .tappedCaptureButton(canvasRect: self.canvasRect, image: captureImage))

                    }) {
                        Text("保存")
                        .frame(width: 80, height: 100, alignment: .center)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 4.0)
                        )
                    }

                    Spacer()
                }
            }
            .alert(isPresented: self.$viewModel.isShowAlert) {
                Alert(title: Text(self.viewModel.alertTitle))
            }
        }
    }
}

extension DrawingView {
    func capture(rect: CGRect) -> UIImage {

        let window = UIWindow(frame: CGRect(origin: rect.origin,
                                            size: rect.size))

        let hosting = UIHostingController(rootView: self.body)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.renderedImage
    }

    func cropImage(with image: UIImage, rect: CGRect) -> UIImage? {
        let ajustRect = CGRect(x: rect.origin.x * image.scale, y: rect.origin.y * image.scale, width: rect.width * image.scale, height: rect.height * image.scale)
        guard let img = image.cgImage?.cropping(to: ajustRect) else { return nil }
        let croppedImage = UIImage(cgImage: img, scale: image.scale, orientation: image.imageOrientation)
        return croppedImage
    }

    //MARK: - Add image to Library
    func imageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {

        } else {

        }
    }
}

struct DrawEditor_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
