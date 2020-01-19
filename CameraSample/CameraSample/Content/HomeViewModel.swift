//
//  ImagePickerViewModel.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/01/18.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject, Identifiable {

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
    private(set) var selectedSourceType: UIImagePickerController.SourceType = .camera
    private(set) var selectedOption: [PhotoAction] = []

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
            .map { true }.assign(to: \.isShowActionSheet, on: self)

        let selectedType = tappedActionSheet
            .assign(to: \.selectedSourceType, on: self)
        let isShowImagePickerView = tappedActionSheet
            .map{ _ in true }
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
