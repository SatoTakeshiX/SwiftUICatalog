//
//  DrawPathView.swift
//  DrawingApp
//
//  Created by satoutakeshi on 2020/02/22.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct DrawPathView: View {
    var drawPointsArray: [DrawPoints]
    init(drawPointsArray: [DrawPoints]) {
        self.drawPointsArray = drawPointsArray
    }
    var body: some View {
        ZStack {
            ForEach(drawPointsArray) { data in
                Path { path in
                    path.addLines(data.points)
                }
                .stroke(data.color, lineWidth: 10)
            }
        }
    }
}

struct DrawPathView_Previews: PreviewProvider {
    static var previews: some View {
        DrawPathView(drawPointsArray: [])
    }
}
