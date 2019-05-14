//
//  RestaurantDetailsViewController.swift
//  Test
//
//  Created by Bryan Gula on 5/14/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController {
    
    var restaurant: Restaurant?
    
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurant = restaurant {
            configure(with: restaurant)
        }
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = Constants.restaurantDetailsVCTitle
        let mapBarButton = UIBarButtonItem.init(image: Constants.mapButton, style: .plain, target: self, action: #selector(RestaurantDetailsViewController.showMap(sender:)))
        mapBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = mapBarButton
    }

    
    func configure(with restaurant: Restaurant) {
        
        //  Setup Map
        
        let coordinate = CLLocation(latitude: restaurant.location.lat, longitude: restaurant.location.lng).coordinate
        
        let regionRadius = MKCoordinateRegion(center: coordinate, latitudinalMeters: Constants.regionRadius, longitudinalMeters: Constants.regionRadius)
        mapKitView.setRegion(regionRadius, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = restaurant.name
        mapKitView.addAnnotation(annotation)
        
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
        addressLabel.text = restaurant.location.address
        
        if let contact = restaurant.contact {
            numberLabel.text = contact.formattedPhone
            
            if let twitter = contact.twitter {
                twitterHandleLabel.text = "@\(twitter)"
            } else {
                twitterHandleLabel.isHidden = true
            }
            
        } else {
            numberLabel.isHidden = true
            twitterHandleLabel.isHidden = true
        }
    }
    
    @objc func showMap(sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
