//
//  SectionView.swift
//  GitHubApiClientSample
//
//  Created by satoutakeshi on 2020/01/29.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct SectionView: View {
    struct Input {
        let repogitories: [Repository]
        let searchKeyword: String
    }

    let input: Input

    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    CardView(input: .init(iconImage: UIImage(named: "rocket")!, title: "swiftui", language: "swift", star: 1000, description: "brabarabarabarabrabarabarabarabrabarabarabara"))
                    ForEach(input.repogitories) { repository in
                        CardView(input: .init(iconImage: UIImage(systemName: "camera")!, title: "swiftui", language: "swift", star: 1000, description: "brabarabarabarabrabarabarabarabrabarabarabara"))

                            .onTapGesture {
                                print("sssss")
                        }
                    }
                }

            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(input: .init(repogitories: testRepository, searchKeyword: "swift"))
            .previewLayout(.sizeThatFits)
    }

    private static var testRepository: [Repository] {
        let repo = Repository(id: 1, name: "swift", description: "brabra", stargazersCount: 100, language: "swift", url: "https://goog.com", owner: Owner(id: 1, avatarUrl: "mark"))
        return [repo, repo, repo]
    }
}
