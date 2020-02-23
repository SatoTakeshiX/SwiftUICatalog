//
//  DrawingViewModel.swift
//  DrawingApp
//
//  Created by satoutakeshi on 2020/02/23.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

final class DrawingViewModel: NSObject, ObservableObject {
    enum Inputs {
        case tappedCaptureButton(canvasRect: CGRect, image: UIImage)
    }

    @Published var isShowAlert: Bool = false
    private(set) var alertTitle: String = ""

    func apply(inputs: Inputs) {
        switch inputs {
            case .tappedCaptureButton(let canvasRect, let image):
            let croppedImage = cropImage(with: image, rect: canvasRect)
            UIImageWriteToSavedPhotosAlbum(croppedImage!, self, #selector(imageSaveCompletion(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

     private func cropImage(with image: UIImage, rect: CGRect) -> UIImage? {
         let ajustRect = CGRect(x: rect.origin.x * image.scale, y: rect.origin.y * image.scale, width: rect.width * image.scale, height: rect.height * image.scale)
         guard let img = image.cgImage?.cropping(to: ajustRect) else { return nil }
         let croppedImage = UIImage(cgImage: img, scale: image.scale, orientation: image.imageOrientation)
         return croppedImage
     }

     //MARK: - Add image to Library
    @objc func imageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        alertTitle = error == nil ? "画像が保存されました" : error?.localizedDescription ?? ""
        isShowAlert = true
     }
}
