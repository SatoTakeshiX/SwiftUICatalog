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
                self.viewModel.tappedButton()
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
    
    @Published var image: UIImage?
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    private(set) var selectedSourceType: UIImagePickerController.SourceType = .camera
    private(set) var selectedOption: [PhotoAction] = []
    private var cancellables: [AnyCancellable] = []
    
    private(set) lazy var tappedButton: () -> Void = { [weak self] in
        guard let self = self else { return }
        self.selectedOption = self.generatePhotoActions()
        self.isShowActionSheet = true
    }
    
    private func generatePhotoActions() -> [PhotoAction] {
        var photoActions: [PhotoAction] = []
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = PhotoAction(action: {
                print("camera")
                self.isShowImagePickerView = true
                self.selectedSourceType = .camera
            }, message: "写真を撮る", imagePickerSourceType: .camera)
            photoActions.append(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = PhotoAction(action: {
                print("photoLibraryAction")
                self.isShowImagePickerView = true
                self.selectedSourceType = .photoLibrary
            }, message: "アルバムから選択", imagePickerSourceType: .photoLibrary)
            photoActions.append(photoLibraryAction)
        }
        return photoActions
    }
    
    struct PhotoAction {
        var action: () -> Void
        var message: String
        var imagePickerSourceType: UIImagePickerController.SourceType
    }
    
}
