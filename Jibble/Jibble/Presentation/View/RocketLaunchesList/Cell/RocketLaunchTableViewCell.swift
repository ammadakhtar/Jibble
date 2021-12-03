//
//  RocketLaunchTableViewCell.swift
//  Jibble
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import UIKit

final class RocketLaunchTableViewCell: UITableViewCell {

    struct UIModel {
        let launchNumber: Int?
        let launchDate: String?
        let rocketDescription: String?
        let rocketImageURL: String?
        let upcoming: Bool?
    }

    var uiModel: UIModel? {
        didSet {
            launchNumberLabel.text = "\(uiModel?.launchNumber ?? 0)"
            launchDateLabel.text = uiModel?.launchDate
            rocketDescriptionLabel.text = uiModel?.rocketDescription
            rocketImageView.isHidden = !(uiModel?.upcoming ?? false)

            if let imageUrl = uiModel?.rocketImageURL {
                ImageDownloadService.getImage(urlString: imageUrl) { [weak self] image in
                    self?.rocketImageView.image = image
                }
            } else {
                self.rocketImageView.image = UIImage(named: "placeholder_large_dark")
            }
        }
    }
    
    // MARK: - IBOutlets and variables
   
    @IBOutlet weak var launchNumberLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketDescriptionLabel: UILabel!
}
