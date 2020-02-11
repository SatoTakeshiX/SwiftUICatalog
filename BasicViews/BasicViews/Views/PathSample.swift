//
//  PathSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/02/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct PathSample: View {
    var body: some View {
        VStack {
            Path { path in
                path.addLines([CGPoint(x: 0, y: 0),
                               CGPoint(x: UIScreen.main.bounds.width, y: 0),
                               CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/3),
                               CGPoint(x: 0, y: 0)])
            }
            .stroke(Color.red, lineWidth: 4)
            Path { path in
                path.addRect(CGRect(x: (UIScreen.main.bounds.width - 100)/2,
                                    y: 0,
                                    width: 100,
                                    height: 100))

            }
           .fill(Color.red)
        }
    }
}

struct PathSample_Previews: PreviewProvider {
    static var previews: some View {
        PathSample()
    }
}
