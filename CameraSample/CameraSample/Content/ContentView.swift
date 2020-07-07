//
//  ContentView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/08.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            EmptyView()
                .navigationBarTitle("Filter App")
                .navigationBarItems(leading: EmptyView(), trailing: HStack {
                    Button(action: {
                        print("jijiji")
                    }, label: {
                        Text("選択")
                    })
                    Button(action: {
                        print("jijiji")
                    }, label: {
                        Text("保存")
                    })
                })
        }
    }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
