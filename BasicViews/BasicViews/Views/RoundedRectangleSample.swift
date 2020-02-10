//
//  RoundedRectangleSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct RoundedRectangleSample: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
        .foregroundColor(.gray)
            .frame(width: 200, height: 200)
    }
}

struct RoundedRectangleSample_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleSample()
    }
}
