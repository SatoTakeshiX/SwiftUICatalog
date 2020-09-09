//
//  TextEditorSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/09.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TextEditorSample: View {
    @State private var text = ""
    var body: some View {
        TextEditor(text: $text)
            .foregroundColor(Color.red)
    }
}

@available(iOS 14.0, *)
struct TextEditorSample_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorSample()
    }
}
