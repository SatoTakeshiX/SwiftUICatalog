//
//  FilterView.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/19.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct FilterImage: View {
    @State private var image: Image?
    let filterType: FilterType
    @Binding var selectedFilter: FilterType?
    let uiimage: UIImage? = UIImage(named: "photo_icon")
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
            FilterImage(filterType: .gaussianBlur, selectedFilter: .constant(nil))
                .previewLayout(.fixed(width: 200, height: 200))
            FilterImage(filterType: .sepiaTone, selectedFilter: .constant(nil))
                .previewLayout(.fixed(width: 200, height: 200))
        }
    }
}
