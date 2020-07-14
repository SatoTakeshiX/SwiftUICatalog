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

struct FilterBanner: View {
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
        FilterBanner()
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

    case pixellate
    case sepiaTone
    case sharpenLuminance
    case photoEffectMono
    case gaussianBlur

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


struct FileterImage: View {
    @State private var image: Image?
    @Binding var filterItem: FilterItem
    let uiimage: UIImage?
    var body: some View {
        Button(action: {
            self.$filterItem.selected.wrappedValue.toggle()
        }) {
            VStack {
                image?
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    //.frame(width: 200, height: 140, alignment: .center)
                    .scaledToFit()
                Text(filterItem.filter.rawValue)
                    .foregroundColor(.black)
            }
        .padding()

        }
            // @bindingのデータをここで更新を検知できないので親ビューで枠をつける
          //  .border(Color.red, width: self.filterItem.selected ? 4 : 0)

        .onAppear(perform: loadImage)
    }

    func loadImage() {
       guard let inputImage = uiimage else { return }
        if let outimage = filterItem.filter.filter(inputImage: inputImage) {
            // convert that to a SwiftUI image
            image = Image(uiImage: outimage)
        }
    }
}


struct FileterImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FileterImage(filterItem: .constant(FilterItem(filter: .gaussianBlur, selected: true)), uiimage: UIImage(named: "snap"))
                .previewLayout(.fixed(width: 200, height: 200))
            FileterImage(filterItem: .constant(FilterItem(filter: .gaussianBlur, selected: false)), uiimage: UIImage(named: "snap"))
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
    @Published var items: [FilterItem] = []
    @Published var pixellate: FilterItem = FilterItem(filter: .pixellate, selected: true)
    @Published var sepiaTone: FilterItem = FilterItem(filter: .sepiaTone, selected: false)
    @Published var sharpenLuminance: FilterItem = FilterItem(filter: .sharpenLuminance, selected: false)
    @Published var photoEffectMono: FilterItem = FilterItem(filter: .photoEffectMono, selected: false)
    @Published var gaussianBlur: FilterItem = FilterItem(filter: .gaussianBlur, selected: false)
}

/*
 case pixellate
 case sepiaTone
 case sharpenLuminance
 case photoEffectMono
 case gaussianBlur
 */
struct FilterBannerView: View {
    @ObservedObject var viewModel = FilterBannerViewModel()
    let uiImage = UIImage(named: "snap")
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                FileterImage(filterItem: $viewModel.pixellate, uiimage: uiImage)
                    .frame(width: 100, height: 200)
                FileterImage(filterItem: $viewModel.sepiaTone, uiimage: uiImage)
                    .frame(width: 100, height: 200)
                FileterImage(filterItem: $viewModel.sharpenLuminance, uiimage: uiImage)
                    .frame(width: 100, height: 200)
                FileterImage(filterItem: $viewModel.photoEffectMono, uiimage: uiImage)
                    .frame(width: 100, height: 200)
                FileterImage(filterItem: $viewModel.gaussianBlur, uiimage: uiImage)
                    .frame(width: 100, height: 200)
            }
        }
        .onAppear {
        }
    }
}

struct FilterBanner2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilterBannerView()
            .previewLayout(.fixed(width: 800, height: 600))

        }
    }
}
