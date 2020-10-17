//
//  TextFieldSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct TextFieldSample: View {
    @State private var inputTextOne: String = ""
    @State private var inputTextTwo: String = ""
    var body: some View {
        
        ScrollView {
            VStack {
                TextField("input search keyword", text: $inputTextOne, onEditingChanged: {_ in
                    print("onEditingChanged")
                }, onCommit: {
                    print("onCommit")
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
                
                TextField("input numbers", text: $inputTextTwo, onEditingChanged: {_ in
                    print("onEditingChanged")
                }, onCommit: {
                    print("onCommit")
                })
                .textFieldStyle(PlainTextFieldStyle())
                .keyboardType(.decimalPad)
            }
        }
        .padding()
    }
}

struct TextFieldSample_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldSample()
    }
}
