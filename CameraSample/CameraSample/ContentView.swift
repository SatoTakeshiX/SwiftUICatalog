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
    @ObservedObject var viewModel: ImagePickerViewModel
    // photoとcameraのときのクロージャーが必要
    var actionSheet: ActionSheet {
        let buttons = viewModel.selectedOption.map { (photAction) -> ActionSheet.Button in

            ActionSheet.Button.default(Text(photAction.message), action: photAction.action)

        }
        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        return ActionSheet(title: Text("画像選択"), message: nil, buttons: buttons + [cancelButton])
    }
    @State var image: Image? = nil
    var body: some View {
        ZStack {
            VStack {
                // safe areaつっきって下に張り付いているViewを作るにはZStackでラップして、Spacerをいれればいいんだ。
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
            .edgesIgnoringSafeArea(.bottom)

            VStack {
                if self.image != nil {
                    Spacer()
                    self.image?.resizable()
                        .scaledToFit()
                    Spacer()
                } else {
                    EmptyImageView()
                }

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
            .edgesIgnoringSafeArea(.top)
            .actionSheet(isPresented: $viewModel.isShowActionSheet) { () -> ActionSheet in
                self.actionSheet
            }
            .sheet(isPresented: $viewModel.isShowImagePickerView) {
                ImagePicker(isShown: self.$viewModel.isShowImagePickerView, image: self.$image, sourceType: self.viewModel.selectedSourceType)
            }
        }
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ImagePickerViewModel())
    }
}

final class ImagePickerViewModel: ObservableObject, Identifiable {

    private var cancellables: [AnyCancellable] = []

    //MARK: Input
    enum Inputs {
        case tappedButton
        case tappedActionSheet(selectType: UIImagePickerController.SourceType)
    }

    //MARK: Outputs
    @Published var image: UIImage?
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    @Published private(set) var selectedSourceType: UIImagePickerController.SourceType = .camera
    @Published private(set) var selectedOption: [PhotoAction] = []

    init() {
        bindOutputs()
    }

    func apply(_ input: Inputs) {
        switch input {
            case .tappedButton:
                tappedButtonStream.send(())
            case .tappedActionSheet(let selectType):
                tappedActionSheet.send(selectType)
        }
    }
    private var tappedButtonStream = PassthroughSubject<Void, Never>()
    private var tappedActionSheet = PassthroughSubject<UIImagePickerController.SourceType, Never>()

    private func bindOutputs() {
        let photoActions = tappedButtonStream
            .map {[weak self] () -> [PhotoAction] in
                guard let self = self else { return [] }
                return self.generatePhotoActions()
        }
        .assign(to: \.selectedOption, on: self)
        let isShow = tappedButtonStream
            .map { () -> Bool in
                return true
        }.assign(to: \.isShowActionSheet, on: self)

        let selectedType = tappedActionSheet
            .assign(to: \.selectedSourceType, on: self)
        let isShowImagePickerView = tappedActionSheet
            .map{ type -> Bool in
                return true
        }
        .assign(to: \.isShowImagePickerView, on: self)

        cancellables += [
            photoActions,
            isShow,
            selectedType,
            isShowImagePickerView
        ]
    }

    private func generatePhotoActions() -> [PhotoAction] {
        var photoActions: [PhotoAction] = []
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = PhotoAction(action: { [weak self] in
                self?.apply(.tappedActionSheet(selectType: .camera))
                }, message: "写真を撮る")
            photoActions.append(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = PhotoAction(action: { [weak self] in
                self?.apply(.tappedActionSheet(selectType: .photoLibrary))
                }, message: "アルバムから選択")
            photoActions.append(photoLibraryAction)
        }
        return photoActions
    }

    struct PhotoAction {
        var action: () -> Void
        var message: String
    }
}
