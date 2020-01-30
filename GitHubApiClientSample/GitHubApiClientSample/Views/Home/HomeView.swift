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

            ScrollView {
                SectionView(input: .init(repogitories: [repo, repo], searchKeyword: "swift"))
                .padding(.bottom, 16)
                .previewLayout(.sizeThatFits)

                SectionView(input: .init(repogitories: [repo, repo], searchKeyword: "swift"))
                .previewLayout(.sizeThatFits)
                SectionView(input: .init(repogitories: [repo, repo], searchKeyword: "swift"))
                .previewLayout(.sizeThatFits)
            }
            .padding(.all, 20)
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
