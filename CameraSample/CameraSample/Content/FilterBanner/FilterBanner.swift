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
    @Binding var uiImage: UIImage?
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("\(viewModel.selectedFilter?.rawValue ?? "フィルターを選択")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                if isShowBanner {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            FilterImage(filterType: .pixellate, selectedFilter: $viewModel.selectedFilter, uiimage: $uiImage)
                            FilterImage(filterType: .sepiaTone, selectedFilter: $viewModel.selectedFilter, uiimage: $uiImage)
                            FilterImage(filterType: .sharpenLuminance, selectedFilter: $viewModel.selectedFilter, uiimage: $uiImage)
                            FilterImage(filterType: .photoEffectMono, selectedFilter: $viewModel.selectedFilter, uiimage: $uiImage)
                            FilterImage(filterType: .gaussianBlur, selectedFilter: $viewModel.selectedFilter, uiimage: $uiImage)
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

final class FilterBannerViewModel: ObservableObject {
    @Published var selectedFilter: FilterType?
    private var cancelables: [Cancellable] = []
    var isSelectedPixellate: Bool {
        return selectedFilter == .pixellate
    }

    var isSelectedSepiaTone: Bool {
        return selectedFilter == .sepiaTone
    }

    var isSelectedSharpenLuminance: Bool {
        return selectedFilter == .sharpenLuminance
    }

    var isSelectedPhotoEffectMono: Bool {
        return selectedFilter == .photoEffectMono
    }

    var isSelectedGaussianBlur: Bool {
        return selectedFilter == .gaussianBlur
    }

    init() {
        let subscriber = $selectedFilter.sink { (type) in
            print("\(type.debugDescription)")
        }
        cancelables.append(subscriber)
    }
}

struct FilterPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilterBannerView(isShowBanner: .constant(true), selectedFilterType: .constant(.gaussianBlur), uiImage: .constant(UIImage(named: "snap")))
    }
}
