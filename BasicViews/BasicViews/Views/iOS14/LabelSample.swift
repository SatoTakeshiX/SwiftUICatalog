//
//  LabelSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/09/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LabelSample: View {
    var body: some View {
        List {
            Label("camera", systemImage: "camera")
            
        }

    }
}

@available(iOS 14.0, *)
struct LabelSample_Previews: PreviewProvider {
    static var previews: some View {
        LabelSample()
    }
}
