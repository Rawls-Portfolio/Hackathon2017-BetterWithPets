//
//  UserModel.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import Foundation

class UserModel {
    var user: String
    private var markers = [MarkerModel]()
    
    init(user: String){
        self.user = user
    }
    
    func add(_ model: MarkerModel){
        markers.append(model)
    }
}
