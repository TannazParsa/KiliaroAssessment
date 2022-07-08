//
//  File.swift
//  KiliaroAssesment
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
import DataModels
import Network

protocol MediaBusinessLogic {
  func populate(request: MediaItem.Populate.Request)
}
protocol MediaDataStore {
  var  mediaResponse: GalleryImagesModels? { get set }
}

class MediaInteractor: MediaBusinessLogic, MediaDataStore {

  var presenter: MediaPresentationLogic?

  // MARK: - Data Store Items
  var mediaResponse: GalleryImagesModels?
  var isLoading = false

  func populate(request: MediaItem.Populate.Request) {
    loadData()
  }

  private func loadData() {

    guard !isLoading else {
      return
    }
    do {
      if let mediaList: GalleryImagesModels? = try DataCache.instance.readCodable(forKey: "mediaList") {
        print("Cached Used")
        self.mediaResponse = mediaList
        self.sendPopulate(state: .success(mediaList ?? []))
        return
      }
    } catch {
      print("Read error \(error.localizedDescription)")
    }
    isLoading = true
    let request = MediaAPI()
    let apiLoader = APILoader(apiHandler: request)
    apiLoader.loadAPIRequest(requestData: [:]) { (model, error) in
      if let error = error {
        self.sendPopulate(state: .failure(error))
      } else {
        do {
          try DataCache.instance.write(codable: model, forKey: "mediaList")
          print("Fetching...")
        } catch {
          print("Write error \(error.localizedDescription)")
        }
        self.mediaResponse = model
        self.sendPopulate(state: .success(model ?? []))
      }
    }
  }

  private func sendPopulate(state: MediaItem.Populate.State) {
    let response = MediaItem.Populate.Response(state: state, mediaList: self.mediaResponse ?? [])
    self.presenter?.presentPopulate(response: response)
  }
}
