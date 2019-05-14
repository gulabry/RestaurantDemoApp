//
//  Constants.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct Constants {
    
    //  Strings
    
    static let restaurantDetailsVCTitle = "Lunch Tyme"
    
    //  URL Strings
    
    static let url = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
    static let bottleRocketUrlString = "https://www.bottlerocketstudios.com"
    
    //  Sizes
    
    static let cellHeight: CGFloat = 180.0
    
    //  Image Names
    
    static let refreshButton = UIImage(named: "ic_webRefresh")!
    static let forwardButton = UIImage(named: "ic_webForward")!
    static let backButton = UIImage(named: "ic_webBack")!
    static let mapButton = UIImage(named: "icon_map")!
    
    //  Cell Names
    
    static let resturantCell = "restaurantCell"
    
    // VC Identifiers
    
    static let restaurantDetailsVC = "restaurantDetailsVC"
    
    //  Map Area Region
    
    static let regionRadius : CLLocationDistance = 1000.0
}

extension UIStoryboard {
    static let main = UIStoryboard.init(name: "Main", bundle: nil)
}
