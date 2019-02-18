//
//  ViewController.swift
//  Hydrants
//
//  Created by student1 on 2/17/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var hydrantList: [HydrantUpdate]?
    var imageStore: ImageStore?
    
    var locationManager: CLLocationManager?
    
    @IBOutlet var hydrantMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        hydrantMap!.delegate = self
        
        addAnnotations()
    
    }
    
    func addAnnotations() {
        for hydrant in hydrantList! {
            let annotation = HydrantAnnotation(hydrant: hydrant)
            hydrantMap.addAnnotation(annotation)
        }
    }

    
    func imageWith(image: UIImage, newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return resizedImage
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is HydrantAnnotation {
            
            let hAnnotation = annotation as! HydrantAnnotation
            let pinAnnotation = MKPinAnnotationView()
            pinAnnotation.annotation = hAnnotation
            pinAnnotation.canShowCallout = true
            
            let image = imageStore?.image(forKey: hAnnotation.hydrant.imageKey)
          
            
            //let frame = CGRect(x: 0, y: 0, width: 200, height: 700)

         
            let photoView = UIImageView()
            photoView.contentMode = .scaleAspectFit
            photoView.clipsToBounds = true
           // photoView.contentScaleFactor = 0.4
            photoView.image = image
            let heightConstraint = NSLayoutConstraint(item: photoView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
            photoView.addConstraint(heightConstraint)

            
           // viewFrame.addSubview(photoView)
            
           // photoView.contentMode = .scaleAspectFit
            pinAnnotation.detailCalloutAccessoryView = photoView
          photoView.sizeToFit()
         //UIView.AutoresizingMask.flexibleHeight
        
            return pinAnnotation
        }
        
        return nil
        
    }
    
    
    
    @IBAction func addHydrantUpdate(_ sender: Any) {
        
        // Get user's current location
        // launch camera (or gallery, on emulator)
        // Save photo tag and data about hydrant
        // add to Hydrant list and update map
        
        locationManager!.requestLocation()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil )
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let image = info[.originalImage] as! UIImage

        picker.dismiss(animated: true, completion: nil)

        
        // get comment
        
        let alertController = UIAlertController(title: "Enter Comments", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Add optional comment"
        }
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            
            let comment = alertController.textFields!.first?.text
            
            let hydrantUpdate = HydrantUpdate(coordinate: (self.locationManager?.location?.coordinate)!, comment: comment)
            
            
            self.imageStore!.setImage(image, forKey: hydrantUpdate.imageKey)
            
            //update map
            
            let annotation = HydrantAnnotation(hydrant: hydrantUpdate)
            self.hydrantMap.addAnnotation(annotation)
            // new Hydrant object
            
          

            }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
         //       picker.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            hydrantMap.showsUserLocation = true
            locationManager!.requestLocation()
            locationManager?.startUpdatingLocation()  // update as app runs
        } else {
            let alert = UIAlertController(title: "Can't display location", message: "Please grant permission in settings", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { (action: UIAlertAction) -> Void in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) } ))
            present(alert, animated: true, completion: nil)
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            hydrantMap.setCenter(location.coordinate, animated: true)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
            hydrantMap.setRegion(region, animated: true)
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}

