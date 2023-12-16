//
//  APIClient.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation
import Combine

typealias QueryParams = [String: Any]

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

protocol APIEndpoint {
    var resourcePath: String { get }
    var httpMethod: HTTPMethod? { get }
    var headers: HTTPContentType? { get }
    var queryParams: QueryParams? { get }
    var timeoutInterval: TimeInterval { get set }
    var fullResourceURL: URL? { get }
}

extension APIEndpoint {
    var headers: HTTPContentType? {
        return nil
    }
    var queryParams: QueryParams? {
        return nil
    }
    var timeoutInterval: TimeInterval {
        return 180
    }

}

enum HTTPMethod: String {
    case post   = "POST"
    case get    = "GET"
    case put    = "PUT"
    case delete = "DELETE"
}

enum HTTPContentType {
    case json, xml, html, multipart(boundary: String), formurlencoded
    
    var contentType: String {
        switch self {
        case .json:
            return "application/json"
        case .xml:
            return "text/xml;charset=utf-8"
        case .html:
            return "text/html;charset=utf-8"
        case .multipart(let boundary):
            return "multipart/form-data; charset=utf-8;  boundary=\(boundary)"
        case .formurlencoded:
            return "application/x-www-form-urlencoded"
        }
    }
}
