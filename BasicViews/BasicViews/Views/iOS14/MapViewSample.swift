//
//  MapViewSample.swift
//  BasicViews
//
//  Created by satoutakeshi on 2020/09/10.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import MapKit

//https://swiftwithmajid.com/2020/07/29/using-mapkit-with-swiftui/

@available(iOS 14.0, *)
struct MapViewSample: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.6593912,
            longitude: 139.7003861
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )

    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

@available(iOS 14.0, *)
struct MapViewSample_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSample()
    }
}
