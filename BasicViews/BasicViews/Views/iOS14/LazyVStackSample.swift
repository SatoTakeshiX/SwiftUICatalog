//
//  LazyVStackSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/04.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LazyVStackSample: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ..< 100) { _ in
                    Image("seal_\(Int.random(in: 1 ... 3))")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct LazyVStackSample_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStackSample()
    }
}

struct VStackSample: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< 100) { _ in
                    Image("seal_\(Int.random(in: 1 ... 3))")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct VStackSample_Previews: PreviewProvider {
    static var previews: some View {
        VStackSample()
    }
}
