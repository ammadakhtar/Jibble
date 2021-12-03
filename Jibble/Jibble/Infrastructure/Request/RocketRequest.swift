//
//  RocketRequest.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

struct RocketRequest: DataRequest {

    var id: String
    
    var url: String {
        let baseURL: String = AppConfiguration().apiBaseURL
        let path: String = "rockets?id=\(id)"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [RocketDetail] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode([RocketDetail].self, from: data)
        return response
    }
}
