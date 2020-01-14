//
//  MapView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    let viewModel: MapViewViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        let region = MKCoordinateRegion(center: .PRCoordinates, span: span)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        viewModel.coordindates.forEach {
            let pinAnnotation = MKPointAnnotation()
            pinAnnotation.coordinate = $0.coordinates
            pinAnnotation.title = $0.magnitude
            uiView.addAnnotation(pinAnnotation)
        }
                
        guard let latestCoordinate = viewModel.coordindates.first?.coordinates else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center: latestCoordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

extension CLLocationCoordinate2D {
    static var PRCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 18.2208, longitude: -66.4500)
    }
}

