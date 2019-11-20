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
    var pinId: Int = 0
    var refreshPoints: Bool = false
    @IBOutlet var mapView: MKMapView!
    var lastTitle: String?
    
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        var annotations: [Annotation] = []
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if pinId != 0 {
            showIndividualPin()
            pinId = 0
        }
        else {
            if let places = accessPoint.shared.geoPlaces {
                for location in places {
                    
                    annotations.append(Annotation(title: location.placename, subtitle: "", coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
                }
                mapView.showAnnotations(annotations, animated: true)
                if places.count == 0 {
                    mapView.userTrackingMode = .follow
                }
            }
        }
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
    }
    

    
    func showIndividualPin() -> Void {
        if let geoPlace = GeoDatabase.shared.geoPlaceForId(pinId) {
            mapView.setCamera(MKMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: geoPlace.latitude, longitude: geoPlace.longitude), fromDistance: geoPlace.viewAltitude ?? 2000, pitch: 0.0, heading: geoPlace.viewHeading ?? 200), animated: false)
            mapView.addAnnotation(Annotation(title: geoPlace.placename, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: geoPlace.latitude, longitude: geoPlace.longitude)))
        }
        pinId = 0
        refreshPoints = true
        mapButton.title = "View All"
        
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
    
    @IBAction func mapButton(_ sender: UIBarButtonItem) {
        if refreshPoints {
            ScriptureRenderer.shared.injectGeoPlaceCollector(accessPoint.shared)
            let _ = ScriptureRenderer.shared.htmlForBookId(SelectedRows.selectedBook!.id, chapter: SelectedRows.selectedChapter ?? 0)
            var annotations: [Annotation] = []
            if let places = accessPoint.shared.geoPlaces {
                for place in places {
                    annotations.append(Annotation(title: place.placename, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)))
                }
            }
            mapButton.title = "My Location"
            mapView.showAnnotations(annotations, animated: true)
            refreshPoints = false
        }
        else {
            mapView.userTrackingMode = .follow
//            if let title = lastTitle {
//                mapView. = title
//            }
        }
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
