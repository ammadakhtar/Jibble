//
//  Optional.swift
//  Jibble
//
//  Created by Ammad Akhtar on 03/12/2021.
//

import Foundation

extension Optional where Wrapped == Date {

    var orCurrent: Date {
        return self ?? Date()
    }
}

extension Optional where Wrapped == Bool {

    var orFalse: Bool {
        return self ?? false
    }
}
