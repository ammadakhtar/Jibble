//
//  AppConfiguration.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

final class AppConfiguration {
    // BASE URL
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("BaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
