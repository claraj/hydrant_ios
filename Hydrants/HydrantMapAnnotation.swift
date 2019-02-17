//
//  HydrantMapAnnotation.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import MapKit

class HydrantAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        return "\(hydrant.comment)"
    }
    
    let hydrant: HydrantUpdate
    
    init(hydrant: HydrantUpdate) {
        self.coordinate = hydrant.coordinates
        self.hydrant = hydrant
    }
    
}
