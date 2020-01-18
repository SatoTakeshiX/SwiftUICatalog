//
//  ContentView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2019/12/21.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    struct EmptyImageView: View {
        var body: some View {
            VStack {
                Spacer()
                Text("画像がありません")
                    .foregroundColor(.gray)
                Spacer()
            }

        }
    }

    struct CustomToolBarView: View {
        var body: some View {
            VStack {
                // SafeAreaの下部まで表示するViewを作るにはZStack配下にいれ、Spacerを入れればいい
                Spacer()
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 112)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay(Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: UIScreen.main.bounds.maxX, y: 0))
                    }.stroke(lineWidth: 1)
                        .fill(Color.gray))
            }
        }
    }

    @ObservedObject private var viewModel: ImagePickerViewModel
    private var actionSheet: ActionSheet {
        let buttons = viewModel.selectedOption.map { (photAction) -> ActionSheet.Button in
            ActionSheet.Button.default(Text(photAction.message), action: photAction.action)
        }
        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        return ActionSheet(title: Text("画像選択"), message: nil, buttons: buttons + [cancelButton])
    }
    @State private var image: Image? = nil

    init(viewModel: ImagePickerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            CustomToolBarView()
                .edgesIgnoringSafeArea(.bottom)

            VStack {
                if self.image != nil {
                    self.image?
                        .resizable()
                        .scaledToFit()
                } else {
                    EmptyImageView()
                }

            }

            VStack {
                Spacer()
                Button(action: {
                    self.viewModel.apply(.tappedButton)
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Text("画像登録")
                    }
                }
            }
        }
        .actionSheet(isPresented: $viewModel.isShowActionSheet) { () -> ActionSheet in
            self.actionSheet
        }
        .sheet(isPresented: $viewModel.isShowImagePickerView) {
            ImagePicker(isShown: self.$viewModel.isShowImagePickerView, image: self.$image, sourceType: self.viewModel.selectedSourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ImagePickerViewModel())
    }
}
