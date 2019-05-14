//
//  LunchViewController.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {
    
    lazy var dataSource : RestaurantDataManager = {
        return RestaurantDataManager(viewController: self)
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension LunchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.resturantCell, for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }

        dataSource.configure(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

extension LunchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard.main.instantiateViewController(withIdentifier: Constants.restaurantDetailsVC) as? RestaurantDetailsViewController,
            let restaurant = dataSource.restaurantFor(indexPath: indexPath) {
            vc.restaurant = restaurant
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.sizeForItem(at: indexPath)
    }
}
