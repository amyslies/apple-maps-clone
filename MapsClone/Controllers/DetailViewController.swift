//
//  DetailViewController.swift
//  MapsClone
//
//  Created by Amy Ly on 8/22/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit
import CoreLocation

protocol DetailViewControllerDelegate {
  func didDismissDetails()
}

class DetailViewController: UIViewController {

  var delegate : DetailViewControllerDelegate!
  @IBOutlet weak var label: UILabel!

  init(withDelegate delegate : DetailViewControllerDelegate) {
    super.init(nibName: nil, bundle: nil)

    self.delegate = delegate
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func configureForLocation(_ location : Location) {
    self.label.text = location.name
  }

  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    delegate.didDismissDetails()
  }
}
