//
//  ContentView.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/27.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct CardView: View {

    struct Input {
        let iconImage: UIImage
        let title: String
        let language: String
        let star: Int
        let description: String
    }

    let input: Input

    init(input: Input) {
        self.input = input
    }

    var body: some View {
        VStack(alignment: .leading) {

            Image(uiImage: input.iconImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .cornerRadius(10)

            Text(input.title)
                .font(.title)
            HStack {
                Text(input.language)
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "star")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                    Text(String(input.star))
                    .font(.footnote)
                    .foregroundColor(.gray)
                }

            }
            Text(input.description)
               // .font(.body)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        }
    .padding()
        .frame(minWidth: 140, maxWidth: 280, minHeight: 180)

            .clipShape(RoundedRectangle(cornerRadius: 10))
        //.cornerRadius(4)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray, lineWidth: 1))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(input: .init(iconImage: UIImage(named: "rocket")!,
                              title: "SwiftUI",
                              language: "Swift",
                              star: 1000,
                              description: "ssssssssssssssssssssssssssssssssssssssssssssssssssssssss"))
        .previewLayout(.sizeThatFits)
    }
}
