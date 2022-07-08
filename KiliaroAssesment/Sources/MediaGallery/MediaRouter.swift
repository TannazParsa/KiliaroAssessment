//
//  GalleryRouter.swift
//  KiliaroAssesment
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
import DataModels
import UIKit

@objc protocol MediaRoutingLogic {
  func routeToFullScreenImage(index: Int)
}
protocol MediaDataPassing {
  var dataStore: MediaDataStore? { get }
}
class MediaRouter: NSObject, MediaRoutingLogic, MediaDataPassing {

  weak var viewController: MediaViewController?

  // MARK: - Data Store Items
  var dataStore: MediaDataStore?
  var presenter: MediaPresentationLogic?


  func routeToFullScreenImage(index: Int) {
    let singleVC = SingleMediaViewController()
    singleVC.selectedIndex = index
    singleVC.galleryImages = dataStore?.mediaResponse ?? []
    viewController?.pushView(viewController: singleVC)
  }
}
