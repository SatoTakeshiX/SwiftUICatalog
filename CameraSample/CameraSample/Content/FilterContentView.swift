//
//  FilterContentView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/14.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine

final class FilterContentViewModel: ObservableObject {

    //MARK: Inputs
    enum Inputs {
        case onAppear
        case tappedImageIcon
        case tappedSaveIcon
        case tappedActionSheet(selectType: UIImagePickerController.SourceType)
    }

    //MARK: Outputs
    @Published var image: UIImage? = UIImage(named: "snap")
    @Published var filteredImage: Image?
    @Published var selectedFilterType: FilterType?
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    @Published var selectedSourceType: UIImagePickerController.SourceType = .camera
    @Published var isShowBanner = false
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

    init() {
        let filterSubscriber = $selectedFilterType.sink { [weak self] (filterType) in
            guard let self = self,
                let filterType = filterType,
                let image = self.image else { return }
            guard let filteredUIImage = self.updateImage(with: image, type: filterType) else { return }
            self.filteredImage = Image(uiImage: filteredUIImage)
        }
        cancellables.append(filterSubscriber)

        let imageSubscriber = $image.sink { [weak self] (uiimage) in
            guard let self = self, let uiimage = uiimage else { return }
            self.filteredImage = Image(uiImage: uiimage)
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
                isShowActionSheet = true
            case .tappedSaveIcon:
                break
            case .tappedActionSheet(let sourceType):
                selectedSourceType = sourceType
                isShowImagePickerView = true
        }
    }

    private func updateImage(with image: UIImage, type filter: FilterType) -> UIImage? {
        return filter.filter(inputImage: image)
    }
}

struct FilterContentView: View {
    @ObservedObject var viewModel = FilterContentViewModel()
    @State private var isShowBanner = false
    var body: some View {
        NavigationView {
            ZStack {
                // https://books.google.co.jp/books?id=S8DPDwAAQBAJ&pg=PT356&lpg=PT356&dq=swiftui+empty+view&source=bl&ots=_BhewlaJya&sig=ACfU3U1-vNwGbgAXhI_YHLc1ECDUhhNGxQ&hl=ja&sa=X&ved=2ahUKEwiqpLWT8MzqAhVCFogKHdkeBiUQ6AEwBnoECAoQAQ#v=onepage&q=swiftui%20empty%20view&f=false
                if viewModel.filteredImage != nil {
                    HStack {
                        // 画面全部をタップするためにSpacerを両方置いている
                        Spacer()
                        viewModel.filteredImage?
                            .resizable()
                            // fillだとタップイベントがきかない？
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                    .border(Color.green, width: 4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            self.viewModel.isShowBanner.toggle()
                        }
                    }
                } else {
                    // emptyviewはサイズがないview。
                    // rectangleと見比べた。rectangleのほうが子ビューを生成していたから、emptyを使っていこう
                        //https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape
                    EmptyView()
                }
                FilterBannerView(isShowBanner: $viewModel.isShowBanner, selectedFilterType: $viewModel.selectedFilterType)
                // transitionでアニメーションするよりは.offsetで移動させたほうがきれいなアニメーションになるな
            }

                .navigationBarTitle("Filter App")
                .navigationBarItems(leading: EmptyView(), trailing: HStack {
                    Button(action: {
                        print("square.and.arrow.down")
                        self.viewModel.apply(.tappedSaveIcon)
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    })
                    Button(action: {
                        print("photo")
                        self.viewModel.apply(.tappedImageIcon)
                    }, label: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .bottom)
                    })
                })
            .actionSheet(isPresented: $viewModel.isShowActionSheet) { () -> ActionSheet in
                self.viewModel.actionSheet
            }
            .sheet(isPresented: $viewModel.isShowImagePickerView) {
                ImagePicker(isShown: self.$viewModel.isShowImagePickerView, image: self.$viewModel.image, sourceType: self.viewModel.selectedSourceType)
            }
        }
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}
