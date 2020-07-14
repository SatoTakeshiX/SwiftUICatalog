//
//  FilterContentView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/14.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct FilterContentView: View {
    @State private var isShowBanner = false
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape
                    .contentShape(Rectangle())
                    
                   .foregroundColor(.clear)
                   //.border(Color.red, width: 4)
                    .onTapGesture {
                        withAnimation {
                            print("ddd")
                            self.isShowBanner.toggle()
                        }
                }
                .navigationBarTitle("Filter App")
                .navigationBarItems(leading: EmptyView(), trailing: HStack {
                    Button(action: {
                        print("square.and.arrow.down")
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    })
                    Button(action: {
                        print("photo")
                    }, label: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .bottom)
                    })
                })

                if isShowBanner {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("filter preview")
                            Spacer()
                        }
                        .frame(height: 130)
                        .background(Color.red)
                        .foregroundColor(.yellow)

                        .transition(.move(edge: .bottom))
                    }
                }
            }
        }
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}
