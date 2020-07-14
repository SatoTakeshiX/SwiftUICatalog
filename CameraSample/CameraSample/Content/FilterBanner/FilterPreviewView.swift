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
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("filter preview")
                Spacer()
            }
            .frame(height: 120)
                // おー、color. opacityで背景色だけ透明に
                //https://stackoverflow.com/questions/58805852/how-can-i-make-a-background-in-swiftui-translucent
            .background(Color.black.opacity(0.5))
                //背景は透明でもなかのコンテンツはしっかり見えてほしい。
            .foregroundColor(.yellow)
                .offset(x: 0, y: isShowBanner ? 0 : 120)
                .animation(.easeIn)
        }
    }
}
struct FilterPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPreviewContentView(isShowBanner: .constant(true))
    }
}
