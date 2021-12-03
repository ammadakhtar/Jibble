//
//  UITableView.swift
//  Jibble
//
//  Created by Umair Afzal on 03/12/2021.
//

import UIKit

extension UITableView {
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToTop(isAnimated: Bool = false) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
            }
        }
    }
}
