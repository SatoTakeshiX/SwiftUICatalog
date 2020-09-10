//
//  ContainerRelativeShapeSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/09/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct ContainerRelativeShapeSample: View {
    var body: some View {
        VStack {
            Image(systemName: "camera")
                .resizable()
                .clipShape(ContainerRelativeShape())
            Text("title")
                .background(ContainerRelativeShape().fill(Color.red))
        }
        //ContainerRelativeShape
    }
}

@available(iOS 14.0, *)
struct ContainerRelativeShapeSample_Previews: PreviewProvider {
    static var previews: some View {
        ContainerRelativeShapeSample()
    }
}
