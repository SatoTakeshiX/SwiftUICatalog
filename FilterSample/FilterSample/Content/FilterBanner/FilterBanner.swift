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
    @Binding var applyingFilter: FilterType?
    @State var selectingFilter: FilterType? = nil
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack {
                    Text("\(self.selectingFilter?.rawValue ?? "フィルターを選択")")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    if self.isShowBanner {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                FilterImage(filterType: .pixellate, selectedFilter: self.$selectingFilter)
                                FilterImage(filterType: .sepiaTone, selectedFilter: self.$selectingFilter)
                                FilterImage(filterType: .sharpenLuminance, selectedFilter: self.$selectingFilter)
                                FilterImage(filterType: .photoEffectMono, selectedFilter: self.$selectingFilter)
                                FilterImage(filterType: .gaussianBlur, selectedFilter: self.$selectingFilter)
                            }
                            .padding([.leading, .trailing], 16)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowBanner = false
                                self.selectingFilter = nil
                            }
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding()
                        }
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.isShowBanner = false
                                self.applyingFilter = self.selectingFilter
                                self.selectingFilter = nil
                            }
                        }) {
                            Image(systemName: "checkmark")
                                .resizable()
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
        FilterBannerView(isShowBanner: .constant(true), applyingFilter: .constant(.gaussianBlur))
            .edgesIgnoringSafeArea(.bottom)
    }
}
