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
        guard let navControl = segue.destination as? UINavigationController,
            let vc = navControl.topViewController as? MarkerDetailViewController else { return }
        vc.delegate = self
        
        if let markermodel = sender as? MarkerModel {
            vc.model = markermodel
        } else if let coordinates = sender as? CLLocationCoordinate2D{
            vc.coordinates = coordinates
        }
    }
    
    // MARK:- Methods
    fileprivate func dropMarkerWith(_ model: MarkerModel) {
        
        switch(model.eventType){
        case .activity: model.eventIcon = #imageLiteral(resourceName: "Activities")
        case .hotspot: model.eventIcon = #imageLiteral(resourceName: "Events")
        case .alert: model.eventIcon = #imageLiteral(resourceName: "Alerts")
        }
        
        let newMarker = CustomMarker(model: model)
        newMarker.map = mapView
        delegate?.save(model)
    }
    
    fileprivate func removeCurrentMarker(){
        // TODO: remove current marker
    }
}

// MARK:- GMSMapView Delegate Methods
extension MapsViewController: GMSMapViewDelegate {
    // new marker
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print(#function)
        currentModel = nil
        performSegue(withIdentifier: "ShowMarkerDetail", sender: coordinate)
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
                removeCurrentMarker()
                dropMarkerWith(model)
        } // else no change
    }
    
    func removeCurrent() {
        if currentModel != nil {
            removeCurrentMarker()
        }
    }
}
