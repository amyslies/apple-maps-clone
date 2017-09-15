//
//  AppDelegate.swift
//  MapsClone
//
//  Created by Amy Ly on 8/18/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.provideGooglePlacesAPIKey()

    let mapsController = MapsViewController(nibName: "MapsViewController", bundle: nil)

    window = UIWindow(frame: UIScreen.main.bounds)
    if let window = window {
      window.rootViewController = mapsController
      window.makeKeyAndVisible()
    }

    return true
  }

  func provideGooglePlacesAPIKey() {
    let url = Bundle.main.url(forResource: "MapsAPIs", withExtension: "plist")
    if let url = url {
//      let data = try Data.init(contentsOf: url) catch error {
//        // handle error
//      }
//      let dict = PropertyListSerialization.propertyList(from: data,
//                                                        options: .mutableContainers,
//                                                        format: nil)
//      if let apiKey
//
//
//      GMSPlacesClient.provideAPIKey(apiKey)
    }
  }
}

