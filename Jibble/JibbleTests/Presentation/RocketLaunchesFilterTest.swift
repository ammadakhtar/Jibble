//
//  RocketLaunchesFilterTest.swift
//  JibbleTests
//
//  Created by Ammad Akhtar on 03/12/2021.
//

import XCTest
import Nimble
import RxSwift
import RxCocoa

@testable import Jibble

class RocketLaunchesFilterTest: XCTestCase {
    // sut
    lazy var rockets: [Rocket] = {
        let rockets = MockDataGenerator().mockRocketLaunchesData()
        return rockets
    }()
   
//    class FetchSongsUseCaseMock: FetchSongsUseCaseProtocol {
//        var expectation: XCTestExpectation?
//        func execute(offSet: Int, page: Int, complete completion: @escaping (Result<[Song], Error>) -> Void) {
//            let songs = SongListViewModelTests().songs
//            let result: Result<[Song], Error> = .success(songs)
//            completion(result)
//        }
//    }
    
    func testFiletrsLogic_WhenAYearIsChosen_ArrayShouldFilterToThatYear_Succeeds() {
        let repository = RocketsRepository(networkService: DefaultNetworkService())
        let useCase = FetchRocketsUseCase(rocketsRepository: repository)
        let viewModel = FetchRocketsViewModel(fetchRocketsUseCase: useCase)
        
        viewModel.rockets = rockets
        // filter All
        viewModel.filterRockets(filter: .all)
        
        let rocketsLaunchedInYearTwentyTwenty = viewModel.filteredRockets.first { rocket in
            return rocket.dateUtc?.getYear() == 2020
        }
        
        let rocketsLaunchedInYearTwentyTwentyOne = viewModel.filteredRockets.first { rocket in
            return rocket.dateUtc?.getYear() == 2021
        }
        
        expect(rocketsLaunchedInYearTwentyTwenty).toNot(beNil())
        expect(rocketsLaunchedInYearTwentyTwentyOne).toNot(beNil())

        
        // // filter 2020
        viewModel.filterRockets(filter: .twentyTwenty)
        
        expect(viewModel.filteredRockets.count).toEventually(equal(1))
        
        // // filter 2021
        viewModel.filterRockets(filter: .twentyTwentyOne)
        
        expect(viewModel.filteredRockets.count).toEventually(equal(2))
    }
}
