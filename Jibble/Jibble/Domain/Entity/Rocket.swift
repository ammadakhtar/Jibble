//
//  Rocket.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

struct Rocket: Codable {
    var id: String?
    var upcoming: Bool?
    var success: Bool?
    var dateUtc: Date?
    var cores: [Core]?
    var details: String?
    var name: String?
    var links: Links?
}

struct Links: Codable {
    var wikipedia: String?
    var patch: Patch?
}

struct Patch: Codable {
    var small: String?
    var large: String?
}

struct Core: Codable {
    var flight: Int?
}
