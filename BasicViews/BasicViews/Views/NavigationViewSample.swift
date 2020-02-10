//
//  NavigationViewSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct NavigationViewSample: View {
    var body: some View {
        NavigationLink(destination: Text("navigation")) {
            Text("NavigationViewSample")
        }
    }
}

struct NavigationViewSample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewSample()
    }
}
