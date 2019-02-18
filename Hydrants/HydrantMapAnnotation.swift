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
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        return "\(dateFormatter.string(from: hydrant.date)). \(hydrant.comment ?? "")"
    }
    
    let hydrant: HydrantUpdate
    
    init(hydrant: HydrantUpdate) {
        self.coordinate = hydrant.coordinate
        self.hydrant = hydrant
    }
    
}
