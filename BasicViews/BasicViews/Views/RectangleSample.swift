//
//  RoundedRectangleSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct RectangleSample: View {
    var body: some View {
        NavigationView {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
                .navigationBarTitle("RoundedRectangle", displayMode: .inline)

        }
    }
}

struct RoundedRectangleSample_Previews: PreviewProvider {
    static var previews: some View {
        RectangleSample()
    }
}
