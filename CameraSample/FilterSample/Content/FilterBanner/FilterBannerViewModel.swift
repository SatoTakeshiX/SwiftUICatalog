//
//  FilterBannerViewModel.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/19.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import Combine

final class FilterBannerViewModel: ObservableObject {
    @Published var selectedFilter: FilterType?
    private var cancelables: [Cancellable] = []
    var isSelectedPixellate: Bool {
        return selectedFilter == .pixellate
    }

    var isSelectedSepiaTone: Bool {
        return selectedFilter == .sepiaTone
    }

    var isSelectedSharpenLuminance: Bool {
        return selectedFilter == .sharpenLuminance
    }

    var isSelectedPhotoEffectMono: Bool {
        return selectedFilter == .photoEffectMono
    }

    var isSelectedGaussianBlur: Bool {
        return selectedFilter == .gaussianBlur
    }

    init() {
        let subscriber = $selectedFilter.sink { (type) in
            print("\(type.debugDescription)")
        }
        cancelables.append(subscriber)
    }
}
