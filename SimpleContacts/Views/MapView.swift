//
//  MapView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}
