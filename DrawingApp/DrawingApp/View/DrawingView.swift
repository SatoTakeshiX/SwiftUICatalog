//
//  DrawEditor.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct DrawingView: View {
    @State var endedDrawPoints: [DrawPoints] = []
    @State var startPoint: CGPoint = CGPoint.zero
    @State var selectedColor: DrawColor = .red
    @State var canvasRect: CGRect = .zero
    @ObservedObject var viewModel = DrawingViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Canvas(
                    endedDrawPoints: self.$endedDrawPoints,
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
}

struct DrawEditor_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
