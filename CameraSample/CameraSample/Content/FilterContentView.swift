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
    @Published var image: UIImage? = UIImage(named: "snap")
    @Published var filteredImage: Image?
    @Published var selectedFilterType: FilterType?

    var cancellables: [Cancellable] = []

    init() {
        let filterSubscriber = $selectedFilterType.sink { [weak self] (filterType) in
            guard let self = self,
                let filterType = filterType,
                let image = self.image else { return }
            //self.filteredImage = self.image
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

    private func updateImage(with image: UIImage, type filter: FilterType) -> UIImage? {
        return filter.filter(inputImage: image)
    }
}

struct FilterContentView: View {
    @ObservedObject var viewModel = FilterContentViewModel()
    @State private var isShowBanner = false
    @State private var image: Image? = Image("snap")
    var body: some View {
        NavigationView {
            ZStack {
                // https://books.google.co.jp/books?id=S8DPDwAAQBAJ&pg=PT356&lpg=PT356&dq=swiftui+empty+view&source=bl&ots=_BhewlaJya&sig=ACfU3U1-vNwGbgAXhI_YHLc1ECDUhhNGxQ&hl=ja&sa=X&ved=2ahUKEwiqpLWT8MzqAhVCFogKHdkeBiUQ6AEwBnoECAoQAQ#v=onepage&q=swiftui%20empty%20view&f=false

                // emptyviewはサイズがないview。
                // rectangleと見比べた。rectangleのほうが子ビューを生成していたから、emptyを使っていこう
                EmptyView()

                    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape

                    .navigationBarTitle("Filter App")
                    .navigationBarItems(leading: EmptyView(), trailing: HStack {
                        Button(action: {
                            print("square.and.arrow.down")
                        }, label: {
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        })
                        Button(action: {
                            print("photo")
                        }, label: {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30, alignment: .bottom)
                        })
                    })

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
                                self.isShowBanner.toggle()
                            }
                    }
                }
                FilterBannerView(isShowBanner: $isShowBanner, selectedFilterType: $viewModel.selectedFilterType)
                // transitionでアニメーションするよりは.offsetで移動させたほうがきれいなアニメーションになるな
            }
        }
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}
