//
//  LocationAnnotation.swift
//  MapsClone
//
//  Created by Amy Ly on 8/21/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import MapKit

class LocationAnnotation : NSObject, MKAnnotation {

  var location : CLLocation
  var name: String?
  var streetAddress: String?

  init(_ location: CLLocation, _ name: String, _ streetAddress: String) {
    self.location = location
    self.name = name
    self.streetAddress = streetAddress
  }

  convenience init(_ location :CLLocation) {
    self.init(location, "", "")
  }

  // MKAnnotation Methods

  var title: String? {
    get {
      return name
    }
  }

  var subtitle: String? {
    get {
      return streetAddress
    }
  }

  var coordinate: CLLocationCoordinate2D {
    get {
      return location.coordinate
    }
  }
}
