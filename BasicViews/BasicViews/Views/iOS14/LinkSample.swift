//
//  LinkSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/09/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LinkSample: View {
    var body: some View {
        VStack {
            Link("google", destination: URL(string: "https://google.com")!)
        }
    }
}

@available(iOS 14.0, *)
struct LinkSample_Previews: PreviewProvider {
    static var previews: some View {
        LinkSample()
    }
}
