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
        if UIDevice.current.userInterfaceIdiom == .pad {
            return restaurants[indexPath.row]
        } else {
            
            var index = indexPath.section
            if index == 0 {
                index += 1
            }
            
            return restaurants[indexPath.section + indexPath.row]
        }
    }
    
    func configure(cell: RestaurantCollectionViewCell, indexPath: IndexPath) {

        if let restaurant = restaurantFor(indexPath: indexPath) {
            cell.nameLabel.text = restaurant.name
            cell.categoryTypeLabel.text = restaurant.category
            
            if let venueImage = ImageManager.getSavedImage(named: restaurant.backgroundImageURL) {
                cell.venueImageView.image = venueImage
            } else {
                cell.venueImageView.image = nil
                cell.venueImageView.downloaded(from: restaurant.backgroundImageURL)
            }
        }
    }
    
    func numberOfSections() -> Int {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return restaurants.count
        } else {
            return restaurants.count / 2
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
    }
}
