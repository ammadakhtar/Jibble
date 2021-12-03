//
//  MockDataGenerator.swift
//  JibbleTests
//
//  Created by Ammad Akhtar on 03/12/2021.
//

import Foundation
@testable import Jibble

class MockDataGenerator {
    
    func mockRocketLaunchesData() -> [Rocket] {
        return getJson(fileName: "RocketLaunchesSample", _type: [Rocket].self) ?? []
    }
    
    func mockRocketDetailData() -> [RocketDetail] {
        return getJson(fileName: "RocketDetailSample", _type: [RocketDetail].self) ?? []
    }
    
    private func getJson<T>(fileName: String, fileExtension: String = "json", _type: T.Type) -> T? where T : Decodable {
        let bundle = Bundle(for: Self.self)
        if let url = bundle.url(forResource: fileName, withExtension: fileExtension) {
            let data = try? Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = decoder.dateStrategy()
            do {
                let data = try decoder.decode(T.self, from: data!)
                return data
            } catch let err {
                print(err)
            }
        }
        
        return nil
    }
}
