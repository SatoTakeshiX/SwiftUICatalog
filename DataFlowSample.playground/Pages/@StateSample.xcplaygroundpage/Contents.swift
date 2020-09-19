//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ParentView: View {
    @State var counter = 0
    var body: some View {
        Button(action: {
            counter += 1
        }, label: {
            Text("counter is \(counter)")
        })
    }
}

PlaygroundPage.current.setLiveView(ParentView()
                                    .frame(width: 200, height: 100).padding())


//: [Next](@next)

/*
 SwiftUIのデータを扱う上での３つの質問
 ・jobを行うために必要なデータはなにか？（値型か参照型か）データは種類。タイトル、進捗状況など
 ・ビューはデータをどのように処理するか。参照だけか、更新するか
 ・データはどこから来るか。親ビューからか。自分で作るのか
 */
