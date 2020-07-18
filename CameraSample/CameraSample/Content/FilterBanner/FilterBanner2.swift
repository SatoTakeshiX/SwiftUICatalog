//
//  FilterBanner.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterBanner2: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .bottom) {
                //FilterIcom()
                Image(systemName: "camera")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 200, alignment: .center)
                Image(systemName: "camera")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 200, alignment: .center)
                Image(systemName: "camera")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 200, alignment: .center)
                Image(systemName: "camera")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 200, alignment: .center)
            }
        }
    }
}

struct FilterBanner_Previews: PreviewProvider {
    static var previews: some View {
        FilterBanner2()
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 200))
    }
}

final class FilterPreviewModel: ObservableObject {
    let filterName: String
    let filterKey: String
    @Published var previewImage: UIImage
    @Published var count: Int = 0

    init(filterName: String, filterKey: String, previewImage: UIImage) {
        self.filterName = filterName
        self.filterKey = filterKey
        self.previewImage = previewImage
    }

    func makeFilterImage() {
        let targetImage = CIImage(image: previewImage)
        CIFilter.sepiaTone()

        if let filter = CIFilter(name: filterKey) {
            filter.setDefaults()
            filter.setValue(targetImage, forKey: kCIInputImageKey)
            if let outputCIImage = filter.outputImage {
                let filteredImage = UIImage(ciImage: outputCIImage)
                DispatchQueue.main.async {
                    self.previewImage = filteredImage
                }
            }
        }
        count = 1
    }
}

struct FilterPreviewIcon: View {
    @ObservedObject var model: FilterPreviewModel
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: model.previewImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
            Text(model.filterName)
            Text("\(model.count)")
        }
        .onAppear {
            self.model.makeFilterImage()
        }
    }
}

struct FilterPreviewIcon_Previews: PreviewProvider {
    static var previews: some View {
        FilterPreviewIcon(model: .init(filterName: "CIBoxBlur", filterKey: "CIBoxBlur", previewImage: UIImage(named: "snap")!))
            .previewLayout(.fixed(width: 100, height: 200))
    }
}

enum FilterType: String, CaseIterable {
    case pixellate = "モザイク"
    case sepiaTone = "セピア"
    case sharpenLuminance = "シャープ"
    case photoEffectMono = "モノクロ"
    case gaussianBlur = "ブラー"

//https://www.hackingwithswift.com/books/ios-swiftui/integrating-core-image-with-swiftui
    private func makeFilter(inputImage: CIImage?) -> CIFilterProtocol {

        switch self {
            case .pixellate:
                let currentFilter = CIFilter.pixellate()
                currentFilter.inputImage = inputImage
                currentFilter.scale = 20
                return currentFilter
            case .sepiaTone:
                let currentFilter = CIFilter.sepiaTone()
                currentFilter.inputImage = inputImage
                currentFilter.intensity = 1
                return currentFilter
            case .sharpenLuminance:
                let currentFilter = CIFilter.sharpenLuminance()
                currentFilter.inputImage = inputImage
                currentFilter.radius = 100
                return currentFilter
            case .photoEffectMono:
                let currentFilter = CIFilter.photoEffectMono()
                currentFilter.inputImage = inputImage
                return currentFilter
            case .gaussianBlur:
                let currentFilter = CIFilter.gaussianBlur()
                currentFilter.inputImage = inputImage
                currentFilter.radius = 10
                return currentFilter
        }
    }

    func filter(inputImage: UIImage) -> UIImage? {
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        let currentFilter = makeFilter(inputImage: beginImage)

        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return nil }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            return UIImage(cgImage: cgimg)
        } else {
            return nil
        }
    }
}

struct FilterImage: View {
    @State private var image: Image?
    let filterType: FilterType
    @Binding var selectedFilter: FilterType?
    @Binding var uiimage: UIImage?
    var body: some View {
        Button(action: {
            self.selectedFilter = self.filterType
        }) {
            VStack {
                image?
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
            }
        }
        .frame(width: 70, height: 80)
        .border(Color.white, width: selectedFilter == filterType ? 4 : 0)
        .onAppear(perform: loadImage)
    }

    func loadImage() {
       guard let inputImage = uiimage else { return }
        DispatchQueue.global(qos: .background).async {
            if let outimage =  self.filterType.filter(inputImage: inputImage) {
                // convert that to a SwiftUI image
                DispatchQueue.main.async {
                    self.image = Image(uiImage: outimage)
                }
            }
        }
    }
}


struct FileterImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilterImage(filterType: .gaussianBlur, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
                .previewLayout(.fixed(width: 200, height: 200))
            FilterImage(filterType: .sepiaTone, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
                .previewLayout(.fixed(width: 200, height: 200))
        }
    }
}

struct FilterItem: Identifiable {
    var filter: FilterType
    var selected: Bool
    let id = UUID()
}

final class FilterBannerViewModel: ObservableObject {

    @Published var selectedFilter: FilterType?
    private var cancelables: [Cancellable] = []

    /**
     case pixellate
     case sepiaTone
     case sharpenLuminance
     case photoEffectMono
     case gaussianBlur
     */
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

struct FilterBannerView2: View {
    @ObservedObject var viewModel = FilterBannerViewModel()
    let uiImage = UIImage(named: "snap")
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                FilterImage(filterType: .pixellate, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
                FilterImage(filterType: .sepiaTone, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
                FilterImage(filterType: .sharpenLuminance, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
                FilterImage(filterType: .photoEffectMono, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
                FilterImage(filterType: .gaussianBlur, selectedFilter: .constant(nil), uiimage: .constant(UIImage(named: "snap")))
            }
        }
        .onAppear {
        }
    }
}

struct FilterBanner2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilterBannerView2()
            .previewLayout(.fixed(width: 800, height: 600))

        }
    }
}
