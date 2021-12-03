//
//  Decoder.swift
//  Jibble
//
//  Created by Ammad Akhtar on 02/12/2021.
//

import Foundation

extension JSONDecoder {
    
    func dateStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .custom({ (decoder) -> Date in
            // Parse the date using a custom `DateFormatter`
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = DateFormatter.iso8601Full.date(from: dateString) {
                return date
            }

            return Date()
        })
    }
}
