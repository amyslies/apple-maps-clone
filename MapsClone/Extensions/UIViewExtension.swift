//
//  UIViewExtension.swift
//  MapsClone
//
//  Created by Amy Ly on 8/20/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit

extension UIView {

  func addFullSizeSubview(_ subview : UIView) {
    self.addSubview(subview)

    let views = ["subview" : subview]

    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
  }

}
