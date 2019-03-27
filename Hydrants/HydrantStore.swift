//
//  HydrantStore.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import UIKit

class HydrantStore {
    
    var hydrantUpdates: [HydrantUpdate] = []
    var imageStore: ImageStore
    
    let hydrantArchiveURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectory.first!
        return documentDirectory.appendingPathComponent("hydrants.archive")
    }()
    
    init() {
        imageStore = ImageStore()
        
        do {
            let data = try Data(contentsOf: hydrantArchiveURL)
            let archivedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [HydrantUpdate]
            hydrantUpdates = archivedItems!
        } catch {
            print("Error unarchiving: \(error)")
            // this is not a problem if it's the first time the app runs, most likely no data has been saved
        }
    }
    
    func addHydrantUpdate(hydrant: HydrantUpdate, image: UIImage) {
        hydrantUpdates.append(hydrant)
        imageStore.setImage(image, forKey: hydrant.imageKey)
        archiveChanges()
    }
    
    func getImage(forKey: String) -> UIImage? {
        return imageStore.image(forKey: forKey)
    }
    
    func archiveChanges() {
        
        
            do {
                
                if #available(iOS 11.0, *) {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: hydrantUpdates, requiringSecureCoding: false)
                     try data.write(to: hydrantArchiveURL)
                }
                else {
                    let data = NSKeyedArchiver.archivedData(withRootObject: hydrantUpdates)
                     try data.write(to: hydrantArchiveURL)
                }
                print("archived items to \(hydrantArchiveURL)")
            } catch {
                print("Error archiving items: \(error)")  // TODO handle this error !
            }
    }
}
