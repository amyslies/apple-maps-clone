//
//  MapsViewController.swift
//  MapsClone
//
//  Created by Amy Ly on 8/18/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, UIScrollViewDelegate, MKMapViewDelegate, LocationsViewControllerDelegate {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var locationsContainerView: UIView!
  @IBOutlet weak var locationsScrollView: SnapScrollView!

  var locationsVC : LocationsViewController!
  var locationAnnotations : [LocationAnnotation]! = []

  // UIViewController Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    locationsScrollView.delegate = self

    mapView.delegate = self
    mapView.showsUserLocation = true

    locationsVC = LocationsViewController.init(withDelegate: self)
    setUpChildViewController(locationsVC, inContainerView: locationsContainerView)
  }

  func setUpChildViewController(_ childVC : UIViewController, inContainerView containerView : UIView) {
    addChildViewController(childVC)
    containerView.addFullSizeSubview(childVC.view)
    childVC.didMove(toParentViewController: self)
  }

  func refreshMap() {
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotations(locationAnnotations)
  }

  // LocationsViewControllerDelegate Methods

  func didSelectLocationAnnotation(_ selectedLocationAnnotation: LocationAnnotation) {
    mapView.selectAnnotation(selectedLocationAnnotation, animated: true)
    // TODO: select location on the map and show location details
  }

  func didUpdateLocationAnnotations(_ locationAnnotations: [LocationAnnotation]) {
    self.locationAnnotations = locationAnnotations
    refreshMap()
  }

  // MKMapViewDelegate Methods



  // UIScrollViewDelegate Methods

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (locationsScrollView.didScrollAboveScrollView()) {
      locationsScrollView.pauseScrolling()
    }

    if (locationsScrollView.didScrollToTopY()) {
      enableScrollView(locationsVC.tableView)
    } else {
      disableScrollView(locationsVC.tableView)
    }
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    targetContentOffset.pointee = locationsScrollView.contentOffset

    locationsScrollView.snapToPositionWithYVelocity(velocity.y)
  }
}
