//
//  MapsViewController.swift
//  MapsClone
//
//  Created by Amy Ly on 8/18/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, UIScrollViewDelegate, MKMapViewDelegate, LocationsViewControllerDelegate, DetailViewControllerDelegate {
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var locationsContainerView: UIView!
  @IBOutlet weak var locationsScrollView: SnapScrollView!
  @IBOutlet weak var detailScrollView: SnapScrollView!
  @IBOutlet weak var detailContainerView: UIView!

  var locationsVC : LocationsViewController!
  var locationAnnotations : [LocationAnnotation]! = []
  var detailVC : DetailViewController!

  // UIViewController Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    locationsScrollView.delegate = self

    detailScrollView.delegate = self
    detailScrollView.isHidden = true

    mapView.delegate = self
    mapView.showsUserLocation = true

    detailVC = DetailViewController.init(withDelegate: self)
    setUpChildViewController(detailVC, inContainerView: detailContainerView)
    locationsVC = LocationsViewController.init(withDelegate: self)
    setUpChildViewController(locationsVC, inContainerView: locationsContainerView)
  }

  func setUpChildViewController(_ childVC: UIViewController, inContainerView containerView: UIView) {
    addChildViewController(childVC)
    containerView.addFullSizeSubview(childVC.view)
    childVC.didMove(toParentViewController: self)
  }

  func refreshMap() {
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotations(locationAnnotations)
  }

  // DetailViewControllerDelegate Methods

  func didDismissDetails() {
    hideDetailsWithCompletion {
      self.detailScrollView.isHidden = false
      self.topScrollView().snapToMiddleY()
    }
  }

  // LocationsViewControllerDelegate Methods

  func didSelectLocationAnnotation(_ selectedLocationAnnotation: LocationAnnotation) {
    mapView.selectAnnotation(selectedLocationAnnotation, animated: true)
    mapView.setCenter(selectedLocationAnnotation.location.coordinate, animated: true)
    detailVC.configureForLocation(selectedLocationAnnotation.location)
    showDetailsWithCompletion(completion: {
      self.locationsScrollView.isHidden = true
    })
  }

  func didUpdateLocationAnnotations(_ locationAnnotations: [LocationAnnotation]) {
    self.locationAnnotations = locationAnnotations
    refreshMap()
  }

  // MKMapViewDelegate Methods
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    if let annotation = view.annotation {
      if !annotation.isKind(of: MKUserLocation.classForCoder()) {
        didSelectLocationAnnotation(annotation as! LocationAnnotation)
      }
    }
  }
  
  // UIScrollViewDelegate Methods

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (topScrollView().didScrollAboveScrollView()) {
      topScrollView().pauseScrolling()
    }

    if (locationsScrollView.didScrollToTopY()) {
      locationsVC.enableScrollView()
    } else {
      locationsVC.disableScrollView()
    }
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    targetContentOffset.pointee = locationsScrollView.contentOffset

    topScrollView().snapToPositionWithYVelocity(velocity.y)
  }

  func hideDetailsWithCompletion(completion: @escaping () -> Void) {
    if (detailScrollView.contentSubviewMinY >= detailScrollView.bottomY) {
      locationsScrollView.scrollContentOutOfView()
    }

    UIView.animate(withDuration: 0.2, animations: {
      self.detailScrollView.snapToMiddleY()
      self.locationsScrollView.isHidden = false
    }) { (halfwayFinished) in
      UIView.animate(withDuration: 0.4, animations: {
        self.detailScrollView.scrollContentOutOfView()
      }, completion: { (finished) in
        self.locationsScrollView.superview?.bringSubview(toFront: self.locationsScrollView)
        completion()
      })
    }
  }

  func showDetailsWithCompletion(completion: @escaping () -> Void) {
    locationsScrollView.snapToMiddleY()
    detailScrollView.isHidden = false

    UIView.animate(withDuration: 0.2, animations: { 
      self.detailScrollView.setContentOffset(self.locationsScrollView.middlePoint, animated: false)
      self.detailScrollView.superview?.bringSubview(toFront: self.detailScrollView)
    }) { (finished) in
      completion()
    }
  }

  func topScrollView() -> SnapScrollView {
    return locationsScrollView.isHidden ? detailScrollView : locationsScrollView
  }
}
