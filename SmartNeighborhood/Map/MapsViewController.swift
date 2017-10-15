//
//  MapsViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapViewDelegate: class {
    func save(_ model: MarkerModel)
}

class MapsViewController: UIViewController {
    
    //MARK:- Properties
    var currentModel: MarkerModel?
    var mapView: GMSMapView?
    var delegate: MapViewDelegate?
    
    // MARK: - View Cycle Methods
    override func loadView() {
        // St. Louis, MO coordinates
        let latitude = 38.62
        let longitude = -90.19
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView!.delegate = self
        view = mapView!

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let markerWithModel = sender as? CustomMarker,
            let navControl = segue.destination as? UINavigationController,
            let vc = navControl.topViewController as? MarkerDetailViewController else { return }
            vc.delegate = self
            vc.model = markerWithModel.model
    }
    
    // MARK:- Methods
    fileprivate func dropMarkerWith(_ model: MarkerModel) {
        let newMarker = CustomMarker(model: model)
        newMarker.map = mapView
        delegate?.save(model)
    }
}

// MARK:- GMSMapView Delegate Methods
extension MapsViewController: GMSMapViewDelegate {
    // new marker
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        currentModel = nil
        performSegue(withIdentifier: "ShowMarkerDetail", sender: nil)
    }
    
    // edit marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(#function)
        guard let markerWithModel = marker as? CustomMarker else { return false }
        currentModel = markerWithModel.model
        performSegue(withIdentifier: "ShowMarkerDetail", sender: currentModel)
        return true
    }
}

// MARK:- MarkerDetailView Delegate Methods
extension MapsViewController: MarkerDetailViewDelegate {
    func unwindToMap(with model: MarkerModel) {
        if currentModel == nil {
            dropMarkerWith(model)
        } else if model != currentModel {
                //TODO: remove current marker
                //dropMarkerWith(model)
        } // else no change
        
        
    }
}
