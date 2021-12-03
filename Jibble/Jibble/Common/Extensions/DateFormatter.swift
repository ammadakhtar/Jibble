//
//  DateFormatter.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
extension DateFormatter {
    
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
    
    static let mmddyyTime12Hours = formatter(format: "dd/MM/yyyy hh:mm a")
    
    private static func formatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        // Setting locale, so that when user changes date/time format in the device, it does not effect our formatting
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}
