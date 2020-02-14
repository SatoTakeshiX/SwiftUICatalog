//
//  ActionSheetSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ActionSheetSample: View {
    
    @State private var isShowActionSheet: Bool = false
    var body: some View {
        Button(action: {
            self.isShowActionSheet = true
        }) {
            Image(systemName: "car")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
        }
        .actionSheet(isPresented: $isShowActionSheet) { () -> ActionSheet in
            ActionSheet(title: Text("交通手段"),
                        message: Text("利用するものを選んでください"),
                        buttons: [
                            .default(Text("自動車"), action: {
                                print("自動車を選んだ")
                            }),
                            .default(Text("電車"), action: {
                                print("電車を選んだ")
                            }),
                            .destructive(Text("徒歩"), action: {
                                print("徒歩を選んだ。大変だよ")
                            }),
                            .cancel(Text("選択しない"), action: {
                                print("選択しない")
                            })
            ])
        }
    }
}

struct ActionSheetSample_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetSample()
    }
}
