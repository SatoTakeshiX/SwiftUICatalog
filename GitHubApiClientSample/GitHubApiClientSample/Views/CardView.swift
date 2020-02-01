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
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .shadow(color: .gray, radius: 1, x: 0, y: 0)

            Text(input.title)
                .foregroundColor(.black)//明示的に色を指定しないとbuttonでくるんだときにおかしくなる
                .font(.title)
                .fontWeight(.bold)
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
                .foregroundColor(.black)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(24)
        .frame(minWidth: 140, minHeight: 180)
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
            .clipped()
        .background(Color.white)

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
