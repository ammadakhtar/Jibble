//
//  FetchRocketViewModel.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import RxSwift
import RxRelay

final class FetchRocketViewModel {
    
    // MARK: - Variables
    
    private let fetchRocketUseCase: FetchRocketUseCaseProtocol
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var rocketName = BehaviorSubject<String?>(value: "")
    var rocketLink = BehaviorSubject<String?>(value: "")
    // Prividing a default image here, which will work as placeholder image
    var rocketImage = BehaviorSubject<UIImage?>(value: UIImage(named: "placeholder_large_dark"))
    var rocketDescription = BehaviorSubject<String?>(value: "")
    let errorMessage: PublishSubject<String> = PublishSubject()
    private let disposeBag = DisposeBag()
    private var id = ""

    // MARK: - Init
    
    init(rocketId: String, fetchRocketUseCase: FetchRocketUseCaseProtocol) {
        self.id = rocketId
        self.fetchRocketUseCase = fetchRocketUseCase
    }
    
    // MARK: - Functions
    
    /// Fetches the list of songs either from the internet or local storage via use case
    func fetchRocketDetail() {
        self.isLoading.accept(true)
        fetchRocketUseCase.execute(id: id)
            .subscribe { [weak self] event in
                self?.isLoading.accept(false)
                guard let self = self else { return }
                switch event {
                case .next(let rocketDetails):
                    self.updateData(rocketDetail: rocketDetails.first)
                case .error(let error):
                    self.errorMessage.onNext(error.localizedDescription)
                case .completed:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    private func updateData(rocketDetail: RocketDetail?) {
        rocketName.onNext(rocketDetail?.name)
        rocketDescription.onNext(rocketDetail?.description)
        rocketLink.onNext(rocketDetail?.wikipedia)
        if let imageURL = rocketDetail?.flickrImages?.first {
            ImageDownloadService.getImage(urlString: imageURL) { [weak self] image in
                self?.rocketImage.onNext(image)
            }
        }
    }
}
