//
//  HydrantUpdate.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import MapKit


class HydrantUpdate: NSObject, NSCoding  {
    
    let imageKey: String
    let date: Date
    let coordinate: CLLocationCoordinate2D
    var comment: String?
    
    init(coordinate: CLLocationCoordinate2D, comment: String?)  {
        self.comment =  comment
        self.coordinate = coordinate
        self.imageKey = UUID().uuidString
        self.date = Date()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageKey, forKey: "imageKey")
        aCoder.encode(date, forKey: "date")
        
        // can't encode structs 
        aCoder.encode(coordinate.latitude, forKey: "coordinate_latitude")
        aCoder.encode(coordinate.longitude, forKey: "coordinate_longitude")
        aCoder.encode(comment, forKey: "comment")
    }
    
    required init?(coder aDecoder: NSCoder) {
        imageKey = aDecoder.decodeObject(forKey: "imageKey") as! String
        date = aDecoder.decodeObject(forKey: "date") as! Date
        let latitude = aDecoder.decodeDouble(forKey: "coordinate_latitude")
        let longitude = aDecoder.decodeDouble(forKey: "coordinate_longitude")
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        comment = aDecoder.decodeObject(forKey: "comment") as? String  // ok to be nil
        
    }
    
    
    
    
}
