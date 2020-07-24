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
                if viewModel.filteredImage != nil {
                    Image(uiImage: viewModel.filteredImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                        .border(Color.green, width: 4)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                self.viewModel.isShowBanner.toggle()
                            }
                    }
                } else {
                    EmptyView()
                }
                FilterBannerView(isShowBanner: $viewModel.isShowBanner, selectedFilterType: $viewModel.selectedFilterType, uiImage: $viewModel.image)
                    .edgesIgnoringSafeArea(.bottom)
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
