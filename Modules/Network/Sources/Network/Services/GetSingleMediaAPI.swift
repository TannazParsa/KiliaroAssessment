//
//  File.swift
//  
//
//  Created by tanaz on 15/04/1401 AP.
//

import Foundation
import UIKit

//public struct GetSingleMediaAPI: APIHandler {
//
//  public struct MediaAPI: APIHandler {
//
//    public init(){}
//
//    public func makeRequest(from param: [String: Any]) -> URLRequest? {
//      let urlString =  "APIPath().gallary
//      if var url = URL(string: urlString) {
//        if param.count > 0 {
//          url = setQueryParams(parameters: param, url: url)
//        }
//        var urlRequest = URLRequest(url: url)
//        setDefaultHeaders(request: &urlRequest)
//        urlRequest.httpMethod = HTTPMethod.get.rawValue
//        return urlRequest
//      }
//      return nil
//    }
//
//    public func parseResponse(data: Data, response: HTTPURLResponse) throws -> GalleryImagesModels {
//      return try defaultParseResponse(data: data,response: response)
//    }
//  }
//}
