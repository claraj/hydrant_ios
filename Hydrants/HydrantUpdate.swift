//
//  HydrantUpdate.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import MapKit


struct HydrantUpdate {
    
    let key = UUID().uuidString
    let imageTag: String
    let date: Date
    let coordinates: CLLocationCoordinate2D
    var comment: String?
    
    
    
}
