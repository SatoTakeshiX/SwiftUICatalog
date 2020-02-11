//
//  ButtonSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ButtonSample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button(action: {
                    print("tapped button")
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("Select Phot")
                    }.frame(width: 150, height: 100)
                }
                .border(Color.gray)
                .cornerRadius(10)

                Button(action: {
                    print("tapped button")
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("Select Phot")
                            .foregroundColor(.black)
                    }
                    .frame(width: 150, height: 100)
                }
                .border(Color.gray)

                Button(action: {
                    print("tapped button")
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("Select Phot")
                            .foregroundColor(.black)
                    }

                }
                .frame(width: 150, height: 100)
                .border(Color.gray)

                Button(action: {
                    print("tapped button")
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("Select Phot")
                            .foregroundColor(.black)
                    }
                    .frame(width: 150, height: 100)
                }
                .border(Color.gray)

                Button(action: {
                    print("tapped button")
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("Select Phot")
                            .foregroundColor(.black)
                    }
                    .frame(width: 150, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 4)
                    )
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }


        
    }
}

struct ButtonSample_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSample()
    }
}
