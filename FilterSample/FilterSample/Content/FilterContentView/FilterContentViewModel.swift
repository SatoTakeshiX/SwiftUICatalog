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
    @Published var applyingFilter: FilterType?
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    @Published var selectedSourceType: UIImagePickerController.SourceType = .camera
    @Published var isShowBanner = false
    @Published var isShowAlert = false
    var alertTitle: String = ""

    var cancellables: [Cancellable] = []

    override init() {
        super.init()
        let filterCancellable = $applyingFilter.sink { [weak self] (filterType) in
            guard let self = self,
                let filterType = filterType,
                let image = self.image else { return }
            guard let filteredUIImage = self.updateImage(with: image, type: filterType) else { return }
            self.filteredImage = filteredUIImage
        }
        cancellables.append(filterCancellable)

        //新しい画像に更新する
        let imageCancellable = $image.sink { [weak self] (uiimage) in
            guard let self = self, let uiimage = uiimage else { return }
            self.filteredImage = uiimage
        }
        cancellables.append(imageCancellable)
    }

    func apply(_ inputs: Inputs) {
        switch inputs {
            case .onAppear:
                if image == nil {
                    isShowActionSheet = true
                }
            case .tappedImageIcon:
                applyingFilter = nil
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
