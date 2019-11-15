//
//  MapController.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/13/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapController : UIViewController {
    
    private var locationManager = CLLocationManager()

    
    @IBOutlet var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var annotations: [Annotation] = []
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
         locationManager.requestWhenInUseAuthorization()
        }
        
        if let places = accessPoint.shared.geoPlaces {
            for location in places {

                annotations.append(Annotation(title: location.placename, subtitle: "", coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
            }
            mapView.showAnnotations(annotations, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .notDetermined, .restricted:
            locationManager.stopUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    @IBAction func centerOnMyLocation(_ sender: Any) {
        if let annotations = accessPoint.shared.geoPlaces {
//            mapView.addAnnotations()
//        mapView.setRegion(MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)), animated: true)
        }
        else {print("Can't find location.")}
    }
}

extension MapController : MKMapViewDelegate {
 func mapView(_ mapView: MKMapView,
 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
 let view = mapView.dequeueReusableAnnotationView(withIdentifier: "SomeID",
 for: annotation)
 view.canShowCallout = true
 view.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "BYU_SM9"))
 view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
 return view
 }
}
