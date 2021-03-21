//
//  FilterContentView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/14.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine
struct FilterContentView: View {
    @StateObject private var viewModel = FilterContentViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                if let filteredImage = viewModel.filteredImage {
                    Image(uiImage: filteredImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .border(Color.green, width: 4)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                viewModel.isShowBanner.toggle()
                            }
                    }
                } else {
                    EmptyView()
                }
                GeometryReader { geometry in
                    FilterBannerView(isShowBanner: $viewModel.isShowBanner, applyingFilter: $viewModel.applyingFilter, bottomSafeAreaInsets: geometry.safeAreaInsets.bottom)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
            .navigationBarTitle("Filter App")
            .navigationBarItems(leading: EmptyView(), trailing: HStack {
                Button(action: {
                    print("square.and.arrow.down")
                    viewModel.apply(.tappedSaveIcon)
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                })
                Button(action: {
                    viewModel.apply(.tappedImageIcon)
                }, label: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .bottom)
                })
            })
            .onAppear {
                viewModel.apply(.onAppear)
            }
            .actionSheet(isPresented: $viewModel.isShowActionSheet) {
                actionSheet
            }
            .sheet(isPresented: $viewModel.isShowImagePickerView) {
                ImagePicker(isShown: $viewModel.isShowImagePickerView, image: $viewModel.image, sourceType: viewModel.selectedSourceType)
            }
            .alert(isPresented: $viewModel.isShowAlert) {
                Alert(title: Text(viewModel.alertTitle))
            }
        }
    }

    private var actionSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = []
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = ActionSheet.Button.default(Text("写真を撮る")) {
                viewModel.apply(.tappedActionSheet(selectType: .camera))
            }
            buttons.append(cameraButton)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryButton = ActionSheet.Button.default(Text("アルバムから選択")) {
                viewModel.apply(.tappedActionSheet(selectType: .photoLibrary))
            }
            buttons.append(photoLibraryButton)
        }
        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        buttons.append(cancelButton)
        let actionSheet = ActionSheet(title: Text("画像選択"), message: nil, buttons: buttons)
        return actionSheet
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}
