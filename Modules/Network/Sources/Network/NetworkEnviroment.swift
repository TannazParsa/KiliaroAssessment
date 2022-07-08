//
//  File.swift
//
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
enum APIEnvironment {
    case development
    case staging
    case production

    func baseURL () -> String {
        return "https://\(domain())\(subdomain())"
    }

    func domain() -> String {
        switch self {
        case .development:
            return "api1.kiliaro.com"
        case .staging:
            return "api1.kiliaro.com"
        case .production:
            return "api1.kiliaro.com"
        }
    }

    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "/shared"
        }
    }

//    func route() -> String {
//        return "/api/v1"
//    }
}
