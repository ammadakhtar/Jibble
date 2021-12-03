//
//  RocketLaunchesMappingTest.swift
//  JibbleTests
//
//  Created by Ammad Akhtar on 03/12/2021.
//

import Nimble
import XCTest
import RxCocoa

@testable import Jibble

class RocketLaunchesMappingTest: XCTestCase {
    // sut
    lazy var rockets: [Rocket] = {
        let rockets = MockDataGenerator().mockRocketLaunchesData()
        return rockets
    }()
    
    func testRocketMapping_WithMockData_Succeeds() {
        let rocket = rockets.first
        expect(rocket?.id).toEventually(equal("5eb87cd9ffd86e000604b32a"))
        expect(rocket?.name).toEventually(equal("FalconSat"))
        expect(rocket?.success).toEventually(equal(true))
        expect(rocket?.upcoming).toEventually(equal(true))
        expect(rocket?.dateUtc).toEventually(equal(DateFormatter.iso8601Full.date(from:"2020-03-24T22:30:00.000Z")))
        expect(rocket?.cores?.count).toEventually(equal(1))
        expect(rocket?.links?.patch?.small).toEventually(equal("https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png"))
        expect(rocket?.links?.patch?.large).to(beNil())
        expect(rocket?.links?.wikipedia).toEventually(equal("https://en.wikipedia.org/wiki/DemoSat"))
        expect(rocket?.details).toEventually(equal("Engine failure at 33 seconds and loss of vehicle"))
        expect(rocket?.cores?.first?.flight).toEventually(equal(1))
    }
}
