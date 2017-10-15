//
//  CustomMarker.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import Foundation
import GoogleMaps

class CustomMarker: GMSMarker {
    var model: MarkerModel
    
    init(model: MarkerModel){
        self.model = model
        super.init()
        let latitude = model.coordinate.latitude
        let longitude = model.coordinate.longitude
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.position = position
        self.title = model.title
        self.isFlat = true
    }
}
