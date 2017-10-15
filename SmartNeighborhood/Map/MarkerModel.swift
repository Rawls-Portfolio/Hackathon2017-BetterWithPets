//
//  MarkerModel.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import Foundation
import GoogleMaps

enum  LocationType {
    case publicProperty, privateProperty
}

// activity: small event
// hotspot: larger event
// alert: found/lost
enum EventType {
    case activity, hotspot, alert
}

class MarkerModel {
    var title: String?
    var typeOfLocation: LocationType
    var eventType: EventType
    var eventIcon: UIImage
    var coordinate: CLLocationCoordinate2D
    var startTime: Date
    var duration: TimeInterval? //if not defined time is indefinite
    var hostName: String
    var hostImage: UIImage
    
    init(title: String?, locationType: LocationType, eventType: EventType, eventIcon: UIImage, coordinates: CLLocationCoordinate2D, startTime: Date, duration: TimeInterval?, hostName: String, hostImage: UIImage){
        self.typeOfLocation = locationType
        self.eventType = eventType
        self.eventIcon = eventIcon
        self.coordinate = coordinates
        self.startTime = startTime
        self.duration = duration
        self.hostName = hostName
        self.hostImage = hostImage
    }
}

extension MarkerModel: Equatable {
    static func ==(lhs: MarkerModel, rhs: MarkerModel) -> Bool {
        return lhs.typeOfLocation == rhs.typeOfLocation &&
            lhs.startTime == rhs.startTime &&
            lhs.hostName == rhs.hostName &&
            lhs.hostImage == rhs.hostImage &&
            lhs.eventType == rhs.eventType &&
            lhs.eventIcon == rhs.eventIcon &&
            lhs.duration == rhs.duration &&
            lhs.coordinate == rhs.coordinate
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
