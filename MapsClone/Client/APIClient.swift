//
//  APIClient.swift
//  MapsClone
//
//  Created by Amy Ly on 9/3/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import GooglePlaces

class APIClient: NSObject {
  static let sharedClient = APIClient()

  func getNearbyPlacesWithCompletion(completion: @escaping ([Location]) -> Void) {
    GMSPlacesClient.shared().currentPlace { (likelihoodList, error) in

      guard error == nil || likelihoodList != nil else {
        completion([])
        return
      }

      var locations : [Location] = []

      if let likelihoodList = likelihoodList {
        likelihoodList.likelihoods.forEach({ (placeLikelihood) in
          locations.append(Location.init(googlePlace: placeLikelihood.place))
        })
      }

      completion(locations)
    }
  }
}
