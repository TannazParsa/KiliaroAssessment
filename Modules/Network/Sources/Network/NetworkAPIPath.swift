//
//  File.swift
//
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation

let baseURL = APIEnvironment.production.baseURL()

public struct APIPath {

  public init() {}

  public var gallary: String { return "\(baseURL)/\(Constants.APIKeys.sharedKey)/media"}

}
