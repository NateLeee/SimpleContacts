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
    
    let locationFetcher: LocationFetcher
    @Binding var title: String
    var location: CLLocationCoordinate2D?
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // Delegate funcs
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "placemark"
            
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                view?.annotation = annotation
            }
            
            return view
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        mkMapView.delegate = context.coordinator
        
        // Fetch location starting...
        locationFetcher.start()
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        addPin(mapView: uiView, title: title, coordinate: location)
    }
    
    private func addPin(mapView: MKMapView, title: String, coordinate: CLLocationCoordinate2D?) {
        if let coordinate = coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
}
