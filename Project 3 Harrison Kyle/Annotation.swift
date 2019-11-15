//
//  Annotation.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/13/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation
import MapKit

class Annotation : NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
