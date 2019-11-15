//
//  GeoPlaceCollector.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 10/28/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation

protocol GeoPlaceCollector {
    func setGeocodedPlaces(_ places: [GeoPlace]?)
}

class Collector: GeoPlaceCollector {

    var geoPlaces: [GeoPlace]?    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        geoPlaces = places
    }
}

class accessPoint {
    static var shared = Collector()
}
