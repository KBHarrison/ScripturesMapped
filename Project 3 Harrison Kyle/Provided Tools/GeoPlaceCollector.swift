//
//  GeoPlaceCollector.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 10/28/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation
import MapKit

protocol GeoPlaceCollector {
    func setGeocodedPlaces(_ places: [GeoPlace]?)
}

class Collector: GeoPlaceCollector {
    
    var geoPlaces: [GeoPlace]?
    
    func setGeocodedPlaces(_ geocodedPlaces: [GeoPlace]?) {
        geoPlaces = geocodedPlaces
        
        if let placeList = geocodedPlaces {
            var places = placeList
            var names: [String] = []
            var duplicatePlaces: [Int] = []
            
            for (index, place) in places.enumerated() {
                if names.contains(place.placename) {
                    duplicatePlaces.append(index)
                }
                else {
                    names.append(place.placename)
                }
            }
            
            // Loop through duplicatePlaces Int index backwards to remove records at the associated index. Backwards so as to not change record indices by removing other records.
            if duplicatePlaces.count > 0 {
                for index in stride(from: duplicatePlaces.count, to: 1, by: -1) {
                    places.remove(at: duplicatePlaces[index - 1])
                }
            }
            geoPlaces = places
        }
    }
}

class accessPoint {
    static var shared = Collector()
}
