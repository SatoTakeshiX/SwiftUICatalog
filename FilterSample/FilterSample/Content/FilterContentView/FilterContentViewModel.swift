//
//  FilterContentViewModel.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/19.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Combine
import UIKit
import SwiftUI

final class FilterContentViewModel: NSObject, ObservableObject {

    //MARK: Inputs
    enum Inputs {
        case onAppear
        case tappedImageIcon
        case tappedSaveIcon
        case tappedActionSheet(selectType: UIImagePickerController.SourceType)
    }

    //MARK: Outputs
    @Published var image: UIImage?
    @Published var filteredImage: UIImage?
    @Published var selectedFilterType: FilterType?
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    @Published var selectedSourceType: UIImagePickerController.SourceType = .camera
    @Published var isShowBanner = false
    @Published var isShowAlert = false
    var alertTitle: String = ""
    lazy var actionSheet: ActionSheet = {

        var buttons: [ActionSheet.Button] = []
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = ActionSheet.Button.default(Text("写真を撮る")) {
                self.apply(.tappedActionSheet(selectType: .camera))
            }
            buttons.append(cameraButton)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryButton = ActionSheet.Button.default(Text("アルバムから選択")) {
                self.apply(.tappedActionSheet(selectType: .photoLibrary))
            }
            buttons.append(photoLibraryButton)
        }

        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        buttons.append(cancelButton)

        let actionSheet = ActionSheet(title: Text("画像選択"), message: nil, buttons: buttons)
        return actionSheet
    }()

    var cancellables: [Cancellable] = []

    override init() {
        super.init()
        let filterSubscriber = $selectedFilterType.sink { [weak self] (filterType) in
            guard let self = self,
                let filterType = filterType,
                let image = self.image else { return }
            guard let filteredUIImage = self.updateImage(with: image, type: filterType) else { return }
            self.filteredImage = filteredUIImage
        }
        cancellables.append(filterSubscriber)

        //新しい画像に更新する
        let imageSubscriber = $image.sink { [weak self] (uiimage) in
            guard let self = self, let uiimage = uiimage else { return }
            self.filteredImage = uiimage
        }
        cancellables.append(imageSubscriber)
    }

    func apply(_ inputs: Inputs) {
        switch inputs {
            case .onAppear:
                if image == nil {
                    isShowActionSheet = true
                }
            case .tappedImageIcon:
                selectedFilterType = nil
                isShowActionSheet = true
            case .tappedSaveIcon:
                UIImageWriteToSavedPhotosAlbum(filteredImage!, self, #selector(imageSaveCompletion(_:didFinishSavingWithError:contextInfo:)), nil)
            case .tappedActionSheet(let sourceType):
                selectedSourceType = sourceType
                isShowImagePickerView = true
        }
    }

    private func updateImage(with image: UIImage, type filter: FilterType) -> UIImage? {
        return filter.filter(inputImage: image)
    }

     //MARK: - Add image to Library
    @objc func imageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        alertTitle = error == nil ? "画像が保存されました" : error?.localizedDescription ?? ""
        isShowAlert = true
     }
}
