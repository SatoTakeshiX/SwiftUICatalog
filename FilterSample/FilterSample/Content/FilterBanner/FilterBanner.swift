//
//  FilterPreviewView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/12.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine

struct FilterBannerView: View {
    @Binding var isShowBanner: Bool
    @Binding var selectedFilterType: FilterType?
    @ObservedObject var viewModel = FilterBannerViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack {
                    Text("\(self.viewModel.selectingFilter?.rawValue ?? "フィルターを選択")")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    if self.isShowBanner {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                FilterImage(filterType: .pixellate, selectedFilter: self.$viewModel.selectingFilter)
                                FilterImage(filterType: .sepiaTone, selectedFilter: self.$viewModel.selectingFilter)
                                FilterImage(filterType: .sharpenLuminance, selectedFilter: self.$viewModel.selectingFilter)
                                FilterImage(filterType: .photoEffectMono, selectedFilter: self.$viewModel.selectingFilter)
                                FilterImage(filterType: .gaussianBlur, selectedFilter: self.$viewModel.selectingFilter)
                            }
                            .padding([.leading, .trailing], 16)
                        }
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
                                self.selectedFilterType = self.$viewModel.selectingFilter.wrappedValue
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
                .background(Color.black.opacity(0.8))
                .foregroundColor(.white)
                .offset(x: 0, y: self.isShowBanner ? 0 : geometry.size.height)
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.8))
                    .frame(height: geometry.safeAreaInsets.bottom)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(x: 0, y: self.isShowBanner ? 0 : geometry.size.height)
            }
        }
    }
}

struct FilterPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilterBannerView(isShowBanner: .constant(true), selectedFilterType: .constant(.gaussianBlur))
    }
}
