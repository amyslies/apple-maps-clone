//
//  ChildControllerScrollActivationProtocol
//  MapsClone
//
//  Created by Amy Ly on 8/20/17.
//  Copyright © 2017 Amy Ly. All rights reserved.
//

import UIKit

extension UIViewController {
  func enableScrollView(_ scrollView : UIScrollView) {
    scrollView.isScrollEnabled = true
  }

  func disableScrollView(_ scrollView : UIScrollView) {
    scrollView.isScrollEnabled = false
  }
}
