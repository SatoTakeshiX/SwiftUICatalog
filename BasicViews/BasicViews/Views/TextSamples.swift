//
//  TextSamples.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct TextSamples: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("longlonglonglonglonglongText")
                    .font(.title)
                .lineLimit(nil)
                .frame(width: 200)
                    .border(Color.gray)
                Text("longlonglonglonglonglongText")
                    .font(.title)
                .lineLimit(nil)

                .fixedSize(horizontal: true, vertical: false)
                    .truncationMode(.tail)
                .frame(width: 200)
                    .border(Color.gray)

                Text("longlonglonglon")
                .lineLimit(1)
                .frame(width: 100, height: 50)
                .truncationMode(.head)

                Text("ddd")
                    .foregroundColor(.green)

                Text("dddddddd")
                .kerning(2)
                //.bold()
                    .font(.title).fontWeight(.heavy)
                .underline()
                .strikethrough()
                .lineSpacing(30)

                    .frame(width: 100)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct TextSamples_Previews: PreviewProvider {
    static var previews: some View {
        TextSamples()
    }
}
