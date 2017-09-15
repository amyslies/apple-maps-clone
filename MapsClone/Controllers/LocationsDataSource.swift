//
//  LocationsDataSource.swift
//  MapsClone
//
//  Created by Amy Ly on 8/20/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationsDataSourceDelegate {
  func didUpdateLocations(_ locations : [Location])
}

class LocationsDataSource: NSObject, CLLocationManagerDelegate {

  var delegate : LocationsDataSourceDelegate!
  var locationManager : CLLocationManager!

  init(withDelegate dataSourceDelegate : LocationsDataSourceDelegate) {
    super.init()

    self.delegate = dataSourceDelegate
    locationManager = CLLocationManager()
    locationManager.delegate = self
  }

  func requestAuthorizationAndLocations() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
      break

    case .authorizedAlways:
      fallthrough
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
      break

    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
      break

    case .authorizedAlways:
      fallthrough
    case .authorizedWhenInUse:
      manager.startUpdatingLocation()
      break

    default:
      manager.stopUpdatingLocation()
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    APIClient.sharedClient.getNearbyPlacesWithCompletion { (nearbyLocations) in
      self.delegate.didUpdateLocations(nearbyLocations)
    }
    locationManager.stopUpdatingLocation()
  }
}
