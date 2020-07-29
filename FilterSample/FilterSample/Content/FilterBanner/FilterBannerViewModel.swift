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
    init() {}
}
