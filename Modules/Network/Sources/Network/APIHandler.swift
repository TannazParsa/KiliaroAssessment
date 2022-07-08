//
//  File.swift
//  
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation

// MARK: APIHandler

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data:RequestDataType) -> URLRequest?
}

public protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

public typealias APIHandler = RequestHandler & ResponseHandler
