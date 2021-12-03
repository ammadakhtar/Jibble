//
//  RocketDetailMappingTest.swift
//  JibbleTests
//
//  Created by Ammad Akhtar on 03/12/2021.
//

import XCTest
import Nimble
import RxCocoa
@testable import Jibble

class RocketDetailMappingTest: XCTestCase {
    // sut
    lazy var rocketDetail: [RocketDetail] = {
        let rocketDetail = MockDataGenerator().mockRocketDetailData()
        return rocketDetail
    }()

    func testRocketDetailMapping_WithMockData_Succeeds() {
        let rocketDetail = rocketDetail.first
        expect(rocketDetail).toNot(beNil())
        expect(rocketDetail?.name).toEventually(equal("Falcon 1"))
        expect(rocketDetail?.description).toEventually(equal("The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth."))
        expect(rocketDetail?.wikipedia).toEventually(equal("https://en.wikipedia.org/wiki/Falcon_1"))
        expect(rocketDetail?.flickrImages?.count).toEventually(equal(2))
    }
}
