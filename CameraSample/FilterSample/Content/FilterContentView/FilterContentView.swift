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
                        Image(uiImage: viewModel.filteredImage!)
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
                FilterBannerView(isShowBanner: $viewModel.isShowBanner, selectedFilterType: $viewModel.selectedFilterType, uiImage: $viewModel.image)
                // transitionでアニメーションするよりは.offsetで移動させたほうがきれいなアニメーションになる
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
                        self.viewModel.apply(.tappedImageIcon)
                    }, label: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .bottom)
                    })
                })
                .onAppear {
                    self.viewModel.apply(.onAppear)
            }
            .actionSheet(isPresented: $viewModel.isShowActionSheet) { () -> ActionSheet in
                self.viewModel.actionSheet
            }
            .sheet(isPresented: $viewModel.isShowImagePickerView) {
                ImagePicker(isShown: self.$viewModel.isShowImagePickerView, image: self.$viewModel.image, sourceType: self.viewModel.selectedSourceType)
            }
            .alert(isPresented: $viewModel.isShowAlert) { () -> Alert in
                Alert(title: Text(self.viewModel.alertTitle))
            }
        }
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}
