//
//  GalleryPresenter.swift
//  KiliaroAssesment
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
import DataModels

protocol MediaPresentationLogic {
  func presentPopulate(response: MediaItem.Populate.Response)
  func presentShowError(response: MediaItem.ShowError.Response)
}

class MediaPresenter: MediaPresentationLogic {

  weak var viewController: MediaDisplayLogic?
  private var mediaList: GalleryImagesModels?

  func presentPopulate(response: MediaItem.Populate.Response) {
    var items: GalleryImagesModels = []

    switch response.state {
    case .loading:
      items += loadingItems()
    case .failure(let error):
      let resp = MediaItem.ShowError.Response(error: error)
      presentShowError(response: resp)
    case .success(let mediaList):
      self.mediaList = mediaList

      let viewModel = MediaItem.Populate.ViewModel(items: mediaList)
      viewController?.displayPopulate(viewModel: viewModel)
    }
  }

  private func loadingItems() -> GalleryImagesModels {
    let items: GalleryImagesModels = []
    return items
  }

  func presentShowError(response: MediaItem.ShowError.Response) {
    let message = (response.error)
    let viewModel = MediaItem.ShowError.ViewModel(message: message.localizedDescription)
    self.viewController?.displayShowError(viewModel: viewModel)
  }
}
