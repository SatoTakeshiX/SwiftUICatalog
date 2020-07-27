//
//  FilterBannerViewModel.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/19.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Combine

final class FilterBannerViewModel: ObservableObject {
    @Published var selectingFilter: FilterType?
    private var cancelables: [Cancellable] = []
    var isSelectedPixellate: Bool {
        return selectingFilter == .pixellate
    }

    var isSelectedSepiaTone: Bool {
        return selectingFilter == .sepiaTone
    }

    var isSelectedSharpenLuminance: Bool {
        return selectingFilter == .sharpenLuminance
    }

    var isSelectedPhotoEffectMono: Bool {
        return selectingFilter == .photoEffectMono
    }

    var isSelectedGaussianBlur: Bool {
        return selectingFilter == .gaussianBlur
    }

    init() {
        let subscriber = $selectingFilter.sink { (type) in
            print("\(type.debugDescription)")
        }
        cancelables.append(subscriber)
    }
}
