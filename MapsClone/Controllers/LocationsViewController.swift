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
  func didSelectLocationAnnotation(_ selectedLocationAnnotation : LocationAnnotation)
  func didUpdateLocationAnnotations(_ locationAnnotations : [LocationAnnotation])
}

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LocationsDataSourceDelegate, ChildControllerScrollActivationProtocol {

  let cellReuseIdentifier = "UITableViewCell"
  var locationAnnotations : [LocationAnnotation] = []
  var locationsDataSource : LocationsDataSource!
  var delegate : LocationsViewControllerDelegate!

  @IBOutlet weak var tableView: UITableView!

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

  // ChildControllerScrollActivationProtocol Methods

  func enableScrollView() {
    tableView.isScrollEnabled = true
  }

  func disableScrollView() {
    tableView.isScrollEnabled = false
  }

  // LocationsDataSourceDelegate Methods

  func didUpdateLocations(_ locations: [CLLocation]) {
    self.locationAnnotations = self.locationAnnotationsFromLocations(locations)
    delegate.didUpdateLocationAnnotations(self.locationAnnotations)
    tableView.reloadData()
  }

  // UITableViewDelegate Methods

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locationAnnotations.count
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
    delegate.didSelectLocationAnnotation(locationAnnotations[indexPath.row])
  }

  func locationAnnotationsFromLocations(_ locations : [CLLocation]) -> [LocationAnnotation] {
    var annotations : [LocationAnnotation] = []
    for location in locations {
      annotations.append(LocationAnnotation.init(location))
    }

    return annotations
  }
}
