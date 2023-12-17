//
//  URLRequest+Extension.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

extension URLRequest {
    
    /// Creates URLRequest
    /// - Parameter request: NetworkRequest
    init(request: NetworkRequest) {
        if let url =  request.fullResourceURL {
            self.init(url: url)
            self.httpMethod = request.httpMethod?.rawValue
            
            if let contentType = request.requestContentType?.contentType {
                self.setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
            
            if let body = request.body {
                self.httpBody = body
            }
        }
        else {
            fatalError("Could not create the request URL")
        }
    }
}
