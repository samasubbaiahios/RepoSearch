//
//  RepoContributorsServiceInteractor.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

struct RepoContributorsServiceInteractor: APIHandler {
    
    func makeRequest(_ request: NetworkRequest) -> URLRequest? {
        let urlRequest = URLRequest(request: request)
        return urlRequest
    }
    func parseResponse(_ data: Data, _ response: HTTPURLResponse?) throws -> Users {
        return try defaultResponseParser(data, response)
    }
}
