//
//  File.swift
//  
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation

public typealias GalleryImagesModels = [GalleryImagesModel]

// MARK: - HomeImageModel
public struct GalleryImagesModel: Codable {

  public let id: String?
  public let userID: String?
  public let mediaType: MediaType?
  public let filename: String?
  public let size: Int64?
  public let createdAt: String?
  public let md5Sum: String
  public let contentType: ContentType?
  public let video: String?
  public let resx, resy: Int?
  public let thumbnailURL, downloadURL: String?
  public let takenAt, guessedTakenAt: Date?


  enum CodingKeys: String, CodingKey {
    case id
    case userID = "user_id"
    case mediaType = "media_type"
    case filename, size
    case createdAt = "created_at"
    case takenAt = "taken_at"
    case md5Sum = "md5sum"
    case contentType = "content_type"
    case video
    case thumbnailURL = "thumbnail_url"
    case downloadURL = "download_url"
    case resx, resy
    case guessedTakenAt = "guessed_taken_at"

  }
}

public enum ContentType: String, Codable {
  case imageJPEG = "image/jpeg"
}

public enum MediaType: String, Codable {
  case image = "image"
}
