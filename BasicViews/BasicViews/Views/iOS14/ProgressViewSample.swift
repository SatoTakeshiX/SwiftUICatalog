//
//  ProgressViewSample.swift
//  BasicViews
//
//  Created by t-sato on 2020/09/09.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

// 文字を乗せれるのと、timerで進行できるのの２つを紹介しよう
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-progress-on-a-task-using-progressview


/**
 /// Creates a progress view for showing determinate progress that generates
 /// its label from a localized string.
 ///
 /// If the value is non-`nil`, but outside the range of `0.0` through
 /// `total`, the progress view pins the value to those limits, rounding to
 /// the nearest possible bound. A value of `nil` represents indeterminate
 /// progress, in which case the progress view ignores `total`.
 ///
 /// This initializer creates a ``Text`` view on your behalf, and treats the
 /// localized key similar to ``Text/init(_:tableName:bundle:comment:)``. See
 /// ``Text`` for more information about localizing strings. To initialize a
 ///  determinate progress view with a string variable, use
 ///  the corresponding initializer that takes a `StringProtocol` instance.
 ///
 /// - Parameters:
 ///     - titleKey: The key for the progress view's localized title that
 ///       describes the task in progress.
 ///     - value: The completed amount of the task to this point, in a range
 ///       of `0.0` to `total`, or `nil` if the progress is
 ///       indeterminate.
 ///     - total: The full amount representing the complete scope of the
 ///       task, meaning the task is complete if `value` equals `total`. The
 ///       default value is `1.0`.
 public init<V>(_ titleKey: LocalizedStringKey, value: V?, total: V = 1.0) where Label == Text, CurrentValueLabel == EmptyView, V : BinaryFloatingPoint

 */
@available(iOS 14.0, *)
struct ProgressViewSample: View {
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            ProgressView("Downloading…")
                .padding()
            ProgressView("Downloading…", value: downloadAmount, total: 100)
                .padding()

        }
        .onReceive(timer) { _ in
            if downloadAmount < 100 {
                downloadAmount += 2
            }
        }
    }
}

@available(iOS 14.0, *)
struct ProgressViewSample_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewSample()
    }
}
