//
//  File.swift
//  
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation

// MARK: Request Handler Supporting methods
public extension RequestHandler {

  func setQueryParams(parameters:[String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }

 func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(Constants.APIHeaders.contentTypeValue, forHTTPHeaderField: Constants.APIHeaders.keyContentType)
    }
}
