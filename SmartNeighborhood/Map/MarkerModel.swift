//
//  MarkerModel.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import Foundation
import GoogleMaps

// activity: small event
// hotspot: larger event
// alert: found/lost
enum EventType {
    case activity, hotspot, alert
    
    static func controlConversion(_ type: Int) -> EventType{
        switch(type){
        case 0: return .activity
        case 1: return .hotspot
        case 2: return .alert
        default: return .activity
        }
    }
}

class MarkerModel {
    var title: String?
    var isPrivateProperty: Bool
    var eventType: EventType
    var eventDesc: String?
    var eventIcon: UIImage?
    var coordinate: CLLocationCoordinate2D
    var startTime: Date
    var endingTime: Date //if not defined time is indefinite
    var hostName: String
    var hostImage: UIImage?
    
    init(title: String?, isPrivateProperty: Bool, eventType: EventType, eventDesc: String?, eventIcon: UIImage?, coordinates: CLLocationCoordinate2D, startTime: Date, endingTime: Date, hostName: String, hostImage: UIImage?){
        self.title = title
        self.isPrivateProperty = isPrivateProperty
        self.eventType = eventType
        self.eventIcon = eventIcon
        self.eventDesc = eventDesc
        self.coordinate = coordinates
        self.startTime = startTime
        self.endingTime = endingTime
        self.hostName = hostName
        self.hostImage = hostImage
    }
}

extension MarkerModel: Equatable {
    static func ==(lhs: MarkerModel, rhs: MarkerModel) -> Bool {
        return lhs.isPrivateProperty == rhs.isPrivateProperty &&
            lhs.startTime == rhs.startTime &&
            lhs.hostName == rhs.hostName &&
            lhs.hostImage == rhs.hostImage &&
            lhs.eventDesc == rhs.eventDesc &&
            lhs.eventType == rhs.eventType &&
            lhs.eventIcon == rhs.eventIcon &&
            lhs.endingTime == rhs.endingTime &&
            lhs.coordinate == rhs.coordinate
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
