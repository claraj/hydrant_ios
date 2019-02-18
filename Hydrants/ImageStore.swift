//
//  ImageStore.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import UIKit

class ImageStore {
    
    // NSString is ObjectiveC
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        if let data = image.jpegData(compressionQuality: 0.5) {
            // atomic means write to a temporary buffer and then finalize write if it all works
            // prevents corrupted data if app crashes during write
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    
    func image(forKey key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        
        // provide from cache if available
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        
        // guard will cause an exception if the image is not found.
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
}
}
