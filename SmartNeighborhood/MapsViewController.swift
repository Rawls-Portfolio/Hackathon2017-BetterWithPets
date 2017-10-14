//
//  MapsViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    override func loadView() {
        // TODO update to current location
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86, 151.20 at zoom level 5
        let latitude = -33.86
        let longitude = 151.20
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        view = mapView

    }
    
    fileprivate func dropMarkerAt(_ latitude: Double, _ longitude: Double, on mapView: GMSMapView, title: String?, snippet: String?) {
        // Creates a marker in the center of the map
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.isFlat = true
        marker.title = title
        marker.snippet = snippet
        marker.map = mapView
    }
}

extension MapsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        dropMarkerAt(coordinate.latitude, coordinate.longitude, on: mapView, title: "Dog Walk", snippet: "Duration: 30 minutes")
    }
}
