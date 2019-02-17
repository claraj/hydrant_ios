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
    
    var locationManager: CLLocationManager?
    
    @IBOutlet var hydrantMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        hydrantMap!.delegate = self
        // show all hydrants on map
        
        addAnnotations()
    
    }
    
    func addAnnotations() {
        
        for hydrant in hydrantList! {
            let annotation = HydrantAnnotation(hydrant: hydrant)
            //annotation.coordinate = hydrant.coordinates
            print("adding coordinate")
            print(hydrant)
            hydrantMap.addAnnotation(annotation)
        }
        
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is HydrantAnnotation {
            let pinAnnotation = MKPinAnnotationView()
            pinAnnotation.annotation = annotation
            pinAnnotation.canShowCallout = true
            
            let photoView = UIImageView(image: UIImage(named: "test_1"))
            photoView.sizeToFit()
            pinAnnotation.detailCalloutAccessoryView = photoView
            

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
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil )
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage]
        
        // new Hydrant object
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            hydrantMap.showsUserLocation = true
            locationManager!.requestLocation()
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

