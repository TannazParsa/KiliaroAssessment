//
//  UIViewControllerExtensions.swift
//  KiliaroAssesment
//
//  Created by tanaz on 16/04/1401 AP.
//

import Foundation
import UIKit

extension UIViewController {

  func pushView(viewController: UIViewController) {
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = .fade
    self.view.window?.layer.add(transition, forKey: kCATransition)
    navigationController?.pushViewController(viewController, animated: true)
  }

  func dismissView() {
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = .reveal
    transition.subtype = .fromBottom
    self.view.window?.layer.add(transition, forKey: kCATransition)
    navigationController?.popViewController(animated: true)
  }
}
