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
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .pixellate, selectedFilter: .constant(nil))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("pixellate")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .sepiaTone, selectedFilter: .constant(nil))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("sepiaTone")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .sharpenLuminance, selectedFilter: .constant(nil))
                    .previewLayout(.fixed(width: 200, height: 200))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("sharpenLuminance")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .photoEffectMono, selectedFilter: .constant(nil))
                    .previewLayout(.fixed(width: 200, height: 200))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("photoEffectMono")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .gaussianBlur, selectedFilter: .constant(nil))
                    .previewLayout(.fixed(width: 200, height: 200))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("gaussianBlur")
            
        }
    }
}
