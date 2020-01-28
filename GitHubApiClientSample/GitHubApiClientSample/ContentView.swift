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
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "camera")
                    //.resizable()
                    //.renderingMode(.original)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 20.0)
                    .foregroundColor(.white)

                Text("sss")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            Text("ssss")
                .foregroundColor(Color.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight:
            0, maxHeight: 200)
        }
        .background(Color.black)
    .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
        .previewLayout(.sizeThatFits)
    }
}
