//
//  FilterPreviewView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/12.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct FilterPreviewContentView: View {
    @Binding var isShowBanner: Bool
    @ObservedObject var viewModel = FilterBannerViewModel()
    let uiImage = UIImage(named: "snap")
    var body: some View {
        VStack {
            Spacer()

            VStack {

                Text("ddd")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        FileterImage(filterItem: $viewModel.pixellate, uiimage: uiImage)
                            .frame(width: 80, height: 80)
                        FileterImage(filterItem: $viewModel.sepiaTone, uiimage: uiImage)
                            .frame(width: 80, height: 80)
                        FileterImage(filterItem: $viewModel.sharpenLuminance, uiimage: uiImage)
                            .frame(width: 80, height: 80)
                        FileterImage(filterItem: $viewModel.photoEffectMono, uiimage: uiImage)
                            .frame(width: 80, height: 80)
                        FileterImage(filterItem: $viewModel.gaussianBlur, uiimage: uiImage)
                            .frame(width: 80, height: 80)
                    }
                    .padding([.leading, .trailing], 16)

                }
               //
                HStack {
                    Button(action: {
                        print("sss")
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
                        print("sss")
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
          //  .frame(height: 300)
                // おー、color. opacityで背景色だけ透明に
                //https://stackoverflow.com/questions/58805852/how-can-i-make-a-background-in-swiftui-translucent
                //背景は透明でもなかのコンテンツはしっかり見えてほしい。
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .offset(x: 0, y: isShowBanner ? 0 : 300)
            .animation(.easeIn)
        }
    }
}
struct FilterPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPreviewContentView(isShowBanner: .constant(true))
    }
}
