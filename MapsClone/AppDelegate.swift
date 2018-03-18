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
    provideGooglePlacesAPIKey()

    let mapsController = MapsViewController(nibName: "MapsViewController", bundle: nil)

    window = UIWindow(frame: UIScreen.main.bounds)
    if let window = window {
      window.rootViewController = mapsController
      window.makeKeyAndVisible()
    }

    return true
  }

  func provideGooglePlacesAPIKey() {
    var myDict: NSDictionary?
    if let path = Bundle.main.path(forResource: "MapsAPIs", ofType: "plist") {
      myDict = NSDictionary(contentsOfFile: path)
    }
    
    if let dict = myDict {
      if let apiKey = dict["googleplaces_key"] as! String? {
          GMSPlacesClient.provideAPIKey(apiKey)
      }
    }
  }
}

