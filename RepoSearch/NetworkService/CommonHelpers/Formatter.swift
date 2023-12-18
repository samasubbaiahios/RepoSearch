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
    
    static func errorHandlers(error: Error) -> String {
        switch error {
        case _ as DecodingError:
            return "Unable to process"
        case let apiError as NetworkErrorTypes:
            switch apiError {
            case .APIError,.ResponseError,.URLRequestFailed,.Unknown:
                return "Unknown Error"
                
            case .noInternetConnection:
                return "No Internet Connection!"
            case .invalidResponse:
                return "Invalid Response"
            case .invalidData:
                return "Invalid Data"

            }
        default:
            return "Unknown Error"
        }
    }
//    let deviceDateFormat = getDeviceLocaleDateFormat()
//    print("Device Locale Date Format: \(deviceDateFormat)")
}
