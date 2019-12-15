//
//  ScrollRectangle.swift
//  GeometryReaderSample
//
//  Created by satoutakeshi on 2019/12/15.
//  Copyright © 2019 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ScrollRectangle: View {
    var body: some View {
        ScrollView {
            VStack {
                GeometryRectangle(color: Color.pink)
                GeometryRectangle(color: Color.red)
                GeometryRectangle(color: Color.blue)
                Spacer()
            }
        }
    }
}

struct ScrollRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ScrollRectangle()
    }
}
