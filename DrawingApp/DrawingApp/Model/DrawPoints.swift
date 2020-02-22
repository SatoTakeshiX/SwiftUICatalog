//
//  DrawPoints.swift
//  DrawingApp
//
//  Created by satoutakeshi on 2020/02/22.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct DrawPoints: Identifiable {
    var points: [CGPoint]
    var color: Color
    var id = UUID()
}

enum DrawType {
    case red
    case clear
    case black

    var color: Color {
        switch self {
            case .red:
                return Color.red
            case .clear:
                return Color.white
            case .black:
                return Color.black
        }
    }
}
