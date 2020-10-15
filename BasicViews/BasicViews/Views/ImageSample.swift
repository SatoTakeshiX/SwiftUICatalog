//
//  ImageSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ImageSample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image("wing")
                    .frame(width: 80, height: 100)

                Image(systemName: "moon")
                    .resizable()
                    .frame(width: 70, height: 100)

                Image(systemName: "moon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 100)

                Image(systemName: "moon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 100)

                Image(systemName: "sunset.fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.red)
                    .frame(width: 80, height: 100)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ImageSample_Previews: PreviewProvider {
    static var previews: some View {
        ImageSample()
    }
}
