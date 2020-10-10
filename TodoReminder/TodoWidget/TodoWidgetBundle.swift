//
//  TodoWidgetBundle.swift
//  TodoWidgetExtension
//
//  Created by satoutakeshi on 2020/10/04.
//

import WidgetKit
import SwiftUI

@main
struct TodoWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodoWidget()
        PriorityWidget()
    }
}
