//
//  FetchRocketsViewModel.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import RxSwift
import RxRelay

enum RocketFilter: Int {
    case all = 0
    case twentyTwenty = 1
    case twentyTwentyOne = 2

    func getYear() -> Int {
        switch self {
        case .all:
            return 0
        case .twentyTwenty:
            return 2020
        case .twentyTwentyOne:
            return 2021
        }
    }
}

final class FetchRocketsViewModel {

    // MARK: - Variables
    private let fetchRocketsUseCase: FetchRocketsUseCaseProtocol
    let cellUIModels: PublishSubject<[RocketLaunchTableViewCell.UIModel]> = PublishSubject()
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let errorMessage: PublishSubject<String> = PublishSubject()
    private let disposeBag = DisposeBag()
    var filteredRockets = [Rocket]()
    var rockets = [Rocket]()

    private var filter: RocketFilter = .all
    // MARK: - Init
    
    init(fetchRocketsUseCase: FetchRocketsUseCaseProtocol) {
        self.fetchRocketsUseCase = fetchRocketsUseCase
    }
    
    // MARK: - Functions
    
    /// Fetches the list of songs either from the internet or local storage via use case
    func fetchRocketLaunchesList() {
        isLoading.accept(true)
        fetchRocketsUseCase.execute()
            .subscribe { [weak self] event in
                self?.isLoading.accept(false)
                guard let self = self else { return }
                switch event {
                case .next(let rockets):
                    self.rockets = rockets
                    self.filterRockets(filter: self.filter)
                case .error(let error):
                    self.errorMessage.onNext(error.localizedDescription)
                case .completed:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    func setupData(rockets: [Rocket]) {
        var uiModels = [RocketLaunchTableViewCell.UIModel]()
        rockets.forEach { rocket in
            uiModels.append(RocketLaunchTableViewCell.UIModel(launchNumber: rocket.cores?.first?.flight, launchDate: rocket.dateUtc?.formatAsMMddyyTime12Hours(), rocketDescription: rocket.details, rocketImageURL: rocket.links?.patch?.small, upcoming: rocket.upcoming))
        }
        cellUIModels.onNext(uiModels)
    }

    func filterRockets(filter: RocketFilter) {
        self.filter = filter
        // remove all records from filtered datasource
        filteredRockets.removeAll()
        switch self.filter {
        case .all:
            // We don't want apply date filter for all, as we need to show all the records regardless of date
            filteredRockets = rockets
        case .twentyTwenty, .twentyTwentyOne:
            // Filter the records based on the year selected, and we need to filter only successful and upcoming laucnhes

            filteredRockets = rockets.filter({
                $0.dateUtc?.getYear() == self.filter.getYear() && ($0.upcoming.orFalse || $0.success.orFalse)
            })
        }

        // Sort the records based on date so that latest information is shown at the top
        self.filteredRockets.sort(by: {$0.dateUtc.orCurrent > $1.dateUtc.orCurrent})
        self.setupData(rockets: self.filteredRockets)
    }

    func getIdOfRocketByIndex(index: Int) -> String? {
        return rockets[index].id
    }
}
