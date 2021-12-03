//
//  RocketDetailVC.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import UIKit
import RxSwift
import SafariServices

final class RocketDetailVC: UIViewController {
    
    // MARK: - IBOutlets and variables
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var rocketDescriptionLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    var viewModel: FetchRocketViewModel!
    var coordinator: RocketDetailCoordinator!
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchRocketDetail()
    }

    // MARK: - Private Methods

    private func setupBindings() {
        viewModel.isLoading
            .asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel.rocketLink
            .observe(on: MainScheduler.instance)
            .bind(to: linkButton.rx.title())
            .disposed(by: disposeBag)
        viewModel.rocketName
            .observe(on: MainScheduler.instance)
            .bind(to: rocketNameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.rocketDescription
            .observe(on: MainScheduler.instance)
            .bind(to: rocketDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.rocketImage
            .observe(on: MainScheduler.instance)
            .bind(to: rocketImageView.rx.image)
            .disposed(by: disposeBag)
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                AlertBuilder.failureAlertWithMessage(message: error)
            }).disposed(by: disposeBag)

        linkButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.openWikipedia()
            }).disposed(by: disposeBag)
    }

    func openWikipedia() {
        let url = try! viewModel.rocketLink.value() ?? ""
        coordinator.present(destination: .wikipedia(url: url))
    }
}

