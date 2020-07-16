//
//  FilterPreviewView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/12.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct FilterBannerView: View {
    @Binding var isShowBanner: Bool
    @Binding var selectedFilterType: FilterType?
    @ObservedObject var viewModel = FilterBannerViewModel()

    let uiImage = UIImage(named: "snap")
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("\(viewModel.selectedFilter?.rawValue ?? "フィルターを選択")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        FilterImage(filterType: .pixellate, selectedFilter: $viewModel.selectedFilter, uiimage: uiImage)
                            .frame(width: 70, height: 80)
                            .border(Color.white, width: viewModel.isSelectedPixellate ? 4 : 0)
                        FilterImage(filterType: .sepiaTone, selectedFilter: $viewModel.selectedFilter, uiimage: uiImage)
                            .frame(width: 70, height: 80)
                        .border(Color.white, width: viewModel.isSelectedSepiaTone ? 4 : 0)
                        FilterImage(filterType: .sharpenLuminance, selectedFilter: $viewModel.selectedFilter, uiimage: uiImage)
                            .frame(width: 70, height: 80)
                        .border(Color.white, width: viewModel.isSelectedSharpenLuminance ? 4 : 0)
                        FilterImage(filterType: .photoEffectMono, selectedFilter: $viewModel.selectedFilter, uiimage: uiImage)
                            .frame(width: 70, height: 80)
                        .border(Color.white, width: viewModel.isSelectedPhotoEffectMono ? 4 : 0)
                        FilterImage(filterType: .gaussianBlur, selectedFilter: $viewModel.selectedFilter, uiimage: uiImage)
                            .frame(width: 70, height: 80)
                        .border(Color.white, width: viewModel.isSelectedGaussianBlur ? 4 : 0)
                    }
                    .padding([.leading, .trailing], 16)
                }

                HStack {
                    Button(action: {
                        withAnimation {
                            self.isShowBanner = false
                        }
                    }) {
                        Image(systemName: "xmark")
                        .resizable()
                            .aspectRatio(contentMode: .fit)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.isShowBanner = false
                            self.selectedFilterType = self.$viewModel.selectedFilter.wrappedValue
                        }
                    }) {
                        Image(systemName: "checkmark")
                        .resizable()
                            .aspectRatio(contentMode: .fit)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                            .padding()
                    }
                }
            }
                // おー、color. opacityで背景色だけ透明に
                //https://stackoverflow.com/questions/58805852/how-can-i-make-a-background-in-swiftui-translucent
                //背景は透明でもなかのコンテンツはしっかり見えてほしい。
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .offset(x: 0, y: isShowBanner ? 0 : 300)
        }
    }
}
struct FilterPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilterBannerView(isShowBanner: .constant(true), selectedFilterType: .constant(.gaussianBlur))
    }
}
