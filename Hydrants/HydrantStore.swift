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
    
    var hydrantUpdates: [HydrantUpdate] = []
    
    func addHydrantUpdate(hydrant: HydrantUpdate) {
        hydrantUpdates.append(hydrant)
        saveChanges()
    }
    
    let hydrantArchiveURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectory.first!
        return documentDirectory.appendingPathComponent("hydrants.archive")
    }()
    
//
//    init() {
//        hydrantUpdates = []
    
//        let test1 = HydrantUpdate(coordinate:
//            CLLocationCoordinate2DMake(45, -93), comment: "Snow gone")
//
//        let test2 = HydrantUpdate(coordinate: CLLocationCoordinate2DMake(45.1, -93.1), comment: "Cleared snow")
//
//
//        hydrantUpdates.append(test2)
//        hydrantUpdates.append(test1)
        
   // }
    
    init() {
        do {
            let data = try Data(contentsOf: hydrantArchiveURL)
            let archivedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [HydrantUpdate]
            hydrantUpdates = archivedItems!
        } catch {
            print("error unarchiving \(error)")  //  // this is not a problem if it's the first time the app runs
            
        }
    }
    
    func saveChanges() -> Bool {
        print("save changes")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: hydrantUpdates, requiringSecureCoding: false)
            try data.write(to: hydrantArchiveURL)
            print("saved items to \(hydrantArchiveURL)")
            return true
        } catch {
            print(error)
            return false
        }
    }
    
}
