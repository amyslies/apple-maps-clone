//
//  Location.swift
//  MapsClone
//
//  Created by Amy Ly on 9/3/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces

enum OpenStatus: Int {
  case open
  case closed
  case unknown
}

enum PriceLevel: Int {
  case unknown = -1
  case free
  case cheap
  case medium
  case high
  case expensive
}

class Location: NSObject {

  var name : String!
  var placeID : String!
  var coordinate : CLLocationCoordinate2D!
  var openStatus : OpenStatus!
  var phoneNumber : String?
  var formattedAddress : String?
  var rating : Float!
  var priceLevel : PriceLevel!

  init(name: String, placeID: String, coordinate : CLLocationCoordinate2D, openStatus : OpenStatus, phoneNumber : String?, formattedAddress : String?, rating : Float, priceLevel : PriceLevel) {

    self.name = name
    self.placeID = placeID
    self.coordinate = coordinate
    self.openStatus = openStatus
    self.phoneNumber = phoneNumber
    self.formattedAddress = formattedAddress
    self.rating = rating
    self.priceLevel = priceLevel

    super.init()
  }

  convenience init(googlePlace : GMSPlace) {
    self.init(name: googlePlace.name,
              placeID: googlePlace.placeID,
              coordinate: googlePlace.coordinate,
              openStatus: OpenStatus(rawValue: googlePlace.openNowStatus.rawValue)!,
              phoneNumber: googlePlace.phoneNumber,
              formattedAddress: googlePlace.formattedAddress,
              rating: googlePlace.rating,
              priceLevel: PriceLevel(rawValue: googlePlace.priceLevel.rawValue)!)
  }

}
