//
//  HomeView.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/29.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var text = ""
    var body: some View {
        // https://stackoverflow.com/questions/57499359/adding-a-textfield-to-navigationbar-with-swiftui
        NavigationView {
            if self.viewModel.isLoading {
                Text("読込中...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .offset(x: 0, y: -200)
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.cardViewInputs) { input in
                        Button(action: {
                            self.viewModel.apply(inputs: .showRepository(urlString: input.url))
                        }) {
                            CardView(input: input)
                        }
                    }
                }
                .padding()
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    TextField("検索キーワードを入力", text: $text, onCommit: {
                        self.viewModel.apply(inputs: .onEnter(text: self.text))
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.asciiCapable)
                        .frame(width: UIScreen.main.bounds.width - 40)
                })
                    .sheet(isPresented: $viewModel.isShowSheet) {
                        SafariView(url: URL(string: self.viewModel.repositoryUrl)!)
                }
                .alert(isPresented: $viewModel.isShowError) {
                    Alert(title: Text("通信時にエラーが発生しました。もう一度やり直してください"))
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(apiService: APIService()))
    }
}
