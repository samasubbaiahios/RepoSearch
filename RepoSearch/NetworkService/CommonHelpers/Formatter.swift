//
//  Formatter.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation

struct CustomFormatter {
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        return formatter
    }()
    
    static let getDeviceLocaleDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
//    let deviceDateFormat = getDeviceLocaleDateFormat()
//    print("Device Locale Date Format: \(deviceDateFormat)")
}
