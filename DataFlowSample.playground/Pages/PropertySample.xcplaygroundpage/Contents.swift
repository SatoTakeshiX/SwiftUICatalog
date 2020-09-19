//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
struct ParentView: View {
    var body: some View {
        HStack {
            ChildView(color: .blue)
            ChildView(color: .yellow)
            ChildView(color: .red)
        }
    }
}

struct ChildView: View {
    let color: Color
    var body: some View {
        Circle().foregroundColor(color)
    }
}

PlaygroundPage.current.setLiveView(ParentView()
                                    .frame(width: 600, height: 400).padding())


/*
 SwiftUIのデータを扱う上での３つの質問
 ・jobを行うために必要なデータはなにか？（値型か参照型か）データは種類。タイトル、進捗状況など
 ・ビューはデータをどのように処理するか。参照だけか、更新するか
 ・データはどこから来るか。親ビューからか。自分で作るのか
 */

