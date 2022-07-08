//
//  File.swift
//  
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation

// MARK: Response Handler - parse default
public struct ServiceError: Error,Codable {
  public let httpStatus: Int
  public let message: String
}

public extension ResponseHandler {
  func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
    let jsonDecoder = JSONDecoder()
    do {
      let body = try jsonDecoder.decode(T.self, from: data)
      if response.statusCode == 200 {
        return body
      } else {
        throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
      }
    } catch  {
      throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
    }

  }
}
