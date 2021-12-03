//
//  RocketLaunchesListVC.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class RocketLaunchesListVC: UIViewController {
    
    // MARK: - IBOutlets and variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private let reuseIdentifier = "launchCell"
    private let disposeBag = DisposeBag()
    var viewModel: FetchRocketsViewModel!
    var coordinator: MainCoordinator!
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupCocoaBindings()
        viewModel.fetchRocketLaunchesList()
    }
    
    // MARK: - Private Functions
    
    private func setupBindings() {
        viewModel.isLoading
            .asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.cellUIModels
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: RocketLaunchTableViewCell.self)) { index, uiModel, cell in
                cell.uiModel = uiModel
            }
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                AlertBuilder.failureAlertWithMessage(message: error)
            }).disposed(by: disposeBag)
    }
    
    private func setupCocoaBindings() {
        // tableView
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let id = self?.viewModel.getIdOfRocketByIndex(index: indexPath.row) ?? ""
                self?.coordinator.present(destination: .details(id: id))

            }).disposed(by: disposeBag)
        
        // segmentControl
        segmentControl
            .rx
            .selectedSegmentIndex
            .subscribe (onNext: {[weak self]  index in
                if let filter = RocketFilter(rawValue: index) {
                    self?.viewModel.filterRockets(filter: filter)
                    self?.tableView.scrollToTop()
                }
            }).disposed(by: disposeBag)
    }
}
