//
//  Date+Extension.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

extension Date {
    func toDateString() -> String {
        let deviceDateFormat = CustomFormatter.getDeviceLocaleDateFormat
        return deviceDateFormat.string(from: self)
    }
}
