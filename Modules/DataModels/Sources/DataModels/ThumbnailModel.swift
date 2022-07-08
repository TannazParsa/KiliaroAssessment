
//
//  File.swift
//
//
//  Created by tanaz on 14/04/1401 AP.
//
import Foundation
import UIKit

public enum ThumbnailImageModes: String {
  case bb
  case crop
  case md
}

public struct ThumbnailModel {
  public let m: ThumbnailImageModes
  public let h: String
  public let w: String

  public init(mode: ThumbnailImageModes, height: CGFloat, width: CGFloat) {
    m = mode
    h = height.roundString
    w = width.roundString
  }

  public func configQuery() -> String {
    var components = URLComponents()
    let m = URLQueryItem(name: "m", value: m.rawValue)
    let h = URLQueryItem(name: "h", value: h)
    let w = URLQueryItem(name: "w", value: w)

    components.queryItems = [w, h, m]
    return components.string ?? ""
  }
}
