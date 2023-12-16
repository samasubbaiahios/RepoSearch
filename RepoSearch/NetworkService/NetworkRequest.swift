//
//  NetworkRequest.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

struct Constants {
    struct APIDetails {
        static let apiScheme = "https"
        static let hostName = "api.github.com"
    }
}

struct NetworkRequest: APIEndpoint {
    
    var requestContentType: HTTPContentType?
    var httpMethod: HTTPMethod?
    var resourcePath: String
    var queryParams: [String: String]?
    var body: Data?
    private var requestTimeoutInterval: TimeInterval = 180
    
    init(resourcePath: String,
         httpMethod: HTTPMethod? = .get,
         queryParams: [String: String]? = nil,
         requestContentType: HTTPContentType? = .json,
         shouldIgnoreCacheData: Bool = false) {
        self.httpMethod = httpMethod
        self.resourcePath = resourcePath
        self.queryParams = queryParams
        self.requestContentType = requestContentType
    }
    
    var timeoutInterval: TimeInterval {
        get {
            return requestTimeoutInterval
        } set {
            requestTimeoutInterval = newValue
        }
    }
}

extension NetworkRequest {
    
    /// Constructing the full URL from base URL, resource path and query params.
    public var fullResourceURL: URL? {
        var components = URLComponents()
        components.scheme = Constants.APIDetails.apiScheme
        components.host = Constants.APIDetails.hostName
        components.path = resourcePath
        if let queryParam = queryParams {
            components.queryItems = [URLQueryItem]()
            let resultComponents = queryParam.map { URLQueryItem(name: $0, value: $1) }
            components.queryItems = resultComponents
        }
        return components.url!
    }
}
