//
//  LocationsViewController.swift
//  MapsClone
//
//  Created by Amy Ly on 8/18/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationsViewControllerDelegate {
  func didSelectLocation(_ selectedLocation : CLLocation)
}

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LocationsDataSourceDelegate {

  let cellReuseIdentifier = "UITableViewCell"
  var locations : [Any] = []
  var locationsDataSource : LocationsDataSource!
  var delegate : LocationsViewControllerDelegate!

  @IBOutlet weak var tableView: UITableView!

  // Initializers

  init(withDelegate delegate : LocationsViewControllerDelegate) {
    super.init(nibName: nil, bundle: nil)
    self.delegate = delegate
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // UIViewController Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellReuseIdentifier)

    locationsDataSource = LocationsDataSource.init(withDelegate: self)
    locationsDataSource.requestAuthorizationAndLocations()
  }

  // LocationsDataSourceDelegate Methods

  func didUpdateLocations(_ locations: [CLLocation]) {
    self.locations = locations
    tableView.reloadData()
  }

  // UITableViewDelegate Methods

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locations.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as UITableViewCell?

    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellReuseIdentifier)
    }

    cell!.textLabel?.text = "location: \(indexPath.row)"

    return cell!
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)

    if let location : CLLocation = locations[indexPath.row] {
      delegate.didSelectLocation(location)
    }
  }

}
