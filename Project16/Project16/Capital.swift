//
//  Capital.swift
//  Project16
//
//  Created by Mohammed Hamdi on 9/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
