//
//  APIHandler.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

enum NetworkErrorTypes: Error {
    case APIError
    case URLRequestFailed
    case ResponseError
    case Unknown
    case noInternetConnection
    case invalidResponse
    case invalidData
}

protocol RequestHandler {
    func makeRequest(_ request: NetworkRequest) -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(_ data: Data, _ response: HTTPURLResponse?) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler
