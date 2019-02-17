//
//  HydrantStore.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import MapKit

class HydrantStore {
    
    var hydrantUpdates: [HydrantUpdate]
    
    init() {
        hydrantUpdates = []
        
        let test1 = HydrantUpdate(imageTag: "123456789", date: Date(), coordinates:
            CLLocationCoordinate2DMake(45, -93), comment: "Snow gone")
        
        let test2 = HydrantUpdate(imageTag: "098765432", date: Date(), coordinates: CLLocationCoordinate2DMake(45.1, -93.1), comment: "Cleared snow")

        
        hydrantUpdates.append(test2)
        hydrantUpdates.append(test1)
        
    }
    
}
