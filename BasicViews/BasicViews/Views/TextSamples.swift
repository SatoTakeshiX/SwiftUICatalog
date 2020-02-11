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
                Text("largeTitle")
                    .font(.largeTitle)
                Text("title")
                    .font(.title)
                Text("headline")
                    .font(.headline)
                Text("subheadline")
                    .font(.subheadline)
                Text("body")
                    .font(.body)
                Text("callout")
                    .font(.callout)
                Text("footnote")
                    .font(.footnote)
                Text("caption")
                    .font(.caption)
            }
            .padding()

            VStack(spacing: 16) {
                Text("longlonglonglonglonglongText")
                    .font(.title)
                    .lineLimit(1)
                    .frame(width: 200)

                Text("longlonglonglonglonglongText")
                    .font(.title)
                    .lineLimit(1)
                    .frame(width: 200, height: 50)
                    .truncationMode(.head)

                Text("longlonglonglonglonglongText")
                    .font(.title)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(width: 200, alignment: .leading)
                    .border(Color.gray)

                Text("change color")
                    .font(.title)
                    .foregroundColor(.green)

                Text("SwiftUI")
                    .kerning(8)
                    .font(.title)
                    .fontWeight(.heavy)
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
