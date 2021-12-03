//
//  Dtae.swift
//  Jibble
//
//  Created by Ammad Akhtar on 02/12/2021.
//

import Foundation

extension Date {
    
    func getYear() -> Int {
        let calenderDate = Calendar.current.dateComponents([.year], from: self)
        return calenderDate.year ?? 0
    }
    
    func formatAsMMddyyTime12Hours() -> String {
        return DateFormatter.mmddyyTime12Hours.string(from: self)
    }
}
