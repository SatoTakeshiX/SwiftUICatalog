//
//  ContentView.swift
//  AppSceneSample
//
//  Created by t-sato on 2020/09/12.
//

import SwiftUI
let adaptiveColums = [
    GridItem(.adaptive(minimum: 100), spacing: 0)
]

struct ContentView: View {
    let colums: [GridItem]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 0) {
                ForEach(0 ..< 100) { _ in
                    Image("seal_\(Int.random(in: 1 ... 3))")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colums: adaptiveColums)
    }
}
