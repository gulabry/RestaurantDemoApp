//
//  RestuarantCellViewModel.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDataManager {
    
    private var restaurants = [Restaurant]()
    private let lunchViewController: LunchViewController
    
    var isPhone = UIDevice.current.userInterfaceIdiom == .phone
    
    init(viewController: LunchViewController) {
        
        self.lunchViewController = viewController
        
        API.getRestaurants { restaurants, errorMessage in
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.lunchViewController.collectionView.reloadData()
            }
        }
    }
    
    
    func restaurantFor(indexPath: IndexPath) -> Restaurant? {
        if isPhone {
            return restaurants[indexPath.section]
        } else {
            return restaurants[(indexPath.section * 2) + indexPath.row]
        }
    }
    
    func configure(cell: RestaurantCollectionViewCell, indexPath: IndexPath) {

        if let restaurant = restaurantFor(indexPath: indexPath) {
            cell.nameLabel.text = restaurant.name
            cell.categoryTypeLabel.text = restaurant.category
            
            guard let savedURL = URL(string: restaurant.backgroundImageURL) else { return }
            
            if let venueImage = ImageManager.getSavedImage(named: savedURL.lastPathComponent) {
                cell.venueImageView.image = venueImage
            } else {
                cell.venueImageView.image = nil
                cell.venueImageView.downloaded(from: restaurant.backgroundImageURL)
            }
        }
    }
    
    func numberOfSections() -> Int {
        return isPhone ? restaurants.count : restaurants.count / 2
    }
    
    func numberOfRowsInSection() -> Int {
        return isPhone ? 1 : 2
    }
    
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        if isPhone {
            return CGSize(width: lunchViewController.collectionView.frame.width, height: Constants.cellHeight)
        } else {
            return CGSize(width: lunchViewController.collectionView.frame.width / 2, height: Constants.cellHeight)
        }
    }
}
