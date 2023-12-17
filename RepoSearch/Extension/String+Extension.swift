//
//  String+Extension.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
