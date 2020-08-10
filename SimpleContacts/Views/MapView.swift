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
    
    let locationFetcher = LocationFetcher()
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        mkMapView.delegate = context.coordinator
        
        // Test 1
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mkMapView.addAnnotation(annotation)
        
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}
