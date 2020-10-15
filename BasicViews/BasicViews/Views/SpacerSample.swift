//
//  SpacerSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct SpacerSample: View {
    var body: some View {
        VStack {
            HStack {
                Image("wing")
                Spacer()
                Image("wing")
            }
            .onTapGesture {
                print("tapped")
            }

            Button(action: {
                print("tapped button")
            }){
                HStack {
                    Image("wing")
                        .renderingMode(.original)
                    Spacer()
                    Image("wing")
                    .renderingMode(.original)
                }
            }

            HStack {
                Image("wing")
                Spacer()
                Image("wing")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("tapped")
            }

        }

    }
}

struct SpacerSample_Previews: PreviewProvider {
    static var previews: some View {
        SpacerSample()
    }
}
