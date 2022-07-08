//
//  File.swift
//  
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
import DataModels

public struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession


   public init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }

   public func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {

        if let urlRequest = apiHandler.makeRequest(from: requestData) {

          urlSession.dataTask(with: urlRequest) { (data, response, error) in

                if let httpResponse = response as? HTTPURLResponse {

                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }

                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }

                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)

                         completionHandler(parsedResponse, nil)
                    } catch {
                         completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }

                }


            }.resume()
        }
    }
}
