//
//  LocationAnnotation.swift
//  MapsClone
//
//  Created by Amy Ly on 8/21/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
  var location : Location
  var name: String?
  var streetAddress: String?

  init(location: Location, name: String, streetAddress: String) {
    self.location = location
    self.name = name
    self.streetAddress = streetAddress
  }

  convenience init(location: Location) {
    self.init(location: location, name: "", streetAddress: "")
  }

  // MKAnnotation Methods

  var coordinate: CLLocationCoordinate2D {
    return location.coordinate
  }

  var title: String? {
    return name
  }

  var subtitle: String? {
    return streetAddress
  }
}
