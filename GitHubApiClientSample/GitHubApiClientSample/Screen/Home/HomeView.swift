//
//  HomeView.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/29.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let repo = Repository(id: 1, name: "swift", description: "brabra", stargazersCount: 100, language: "swift", url: "https://goog.com", owner: Owner(id: 1, avatarUrl: "mark"))
    @State private var text = ""
    
    var body: some View {

        // https://stackoverflow.com/questions/57499359/adding-a-textfield-to-navigationbar-with-swiftui
        NavigationView {
            ScrollView(showsIndicators: false) {

                ForEach([repo]) { repo in
                    Button(action: {
                        print("dd")
                    }) {
                        CardView(input: .init(iconImage: UIImage(named: "rocket")!, title: "swiftui", language: "swift", star: 1000, description: "brabarabarabarabrabarabarabarabrabarabarabara"))
                    }


                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HStack {
                TextField("検索キーワードを入力", text: self.$text, onCommit: {

                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .frame(width: UIScreen.main.bounds.width - 40)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()

    }
}
