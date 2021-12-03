//
//  RocketsRequest.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

struct RocketsRequest: DataRequest {

    var url: String {
        let baseURL: String = AppConfiguration().apiBaseURL
        let path: String = "launches"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Rocket] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = decoder.dateStrategy()
        let response = try decoder.decode([Rocket].self, from: data)
        return response
    }
}
