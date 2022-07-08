//
//  MediaItem.swift
//  KiliaroAssesment
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
import DataModels

enum MediaItem {
  enum Populate {
      typealias State = FetchState<GalleryImagesModels, Error>
    struct Request {
    }
    struct Response {
      let state: State
      let mediaList: GalleryImagesModels

    }
    struct ViewModel {
      let items: GalleryImagesModels
    }
  }

  enum ShowError {
    struct Response {
      let error: Error
    }
    struct ViewModel {
      let message: String
    }
  }
}
