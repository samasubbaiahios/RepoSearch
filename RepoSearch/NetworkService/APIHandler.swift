//
//  APIHandler.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import Foundation

typealias APIHandler = RequestHandler & ResponseHandler

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

extension ResponseHandler {
    
    /// Decodes the response data to required entity object
    /// - Parameters:
    ///   - responseData: JSON Data
    ///   - response: HTTPURLResponse
    /// - Throws: APIError or ResponseError
    /// - Returns: Decoded object
    func defaultResponseParser<T:Codable>(_ responseData: Data?, _ response: HTTPURLResponse?) throws -> T {
        if response?.statusCode == 401 {
            throw NetworkErrorTypes.ResponseError
        }
        else {
            guard let data = responseData, let statusCode = response?.statusCode, 200...299 ~= statusCode else {
                throw NetworkErrorTypes.APIError
            }
            
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(T.self, from: data)
        }
    }
}
