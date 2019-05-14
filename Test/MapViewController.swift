//
//  MapViewController.swift
//  Test
//
//  Created by Bryan Gula on 5/14/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var coordinates = [CLLocationCoordinate2D]()
    var annotations = [MKPointAnnotation]()
    var mapRect : MKMapRect?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let rect = mapRect else { return }
        mapView.addAnnotations(annotations)
        mapView.setVisibleMapRect(rect, animated: true)
    }
    
    func configure(with restaurants: [Restaurant]) {
        
        var visableMapRect: MKMapRect? = nil
        
        for restaurant in restaurants {
            coordinates.append(CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lng))
            let coordinate = CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lng)
            let mapPoint = MKMapPoint(coordinate)
            let pointRect = MKMapRect(x: mapPoint.x, y: mapPoint.y, width: 0.0, height: 0.0)
            if visableMapRect == nil {
                visableMapRect = pointRect
            } else {
                visableMapRect = visableMapRect?.union(pointRect)
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = restaurant.name
            annotations.append(annotation)
        }
        
        mapRect = visableMapRect
    }
    
    
    // MARK: - Navigation

    @IBAction func dismissNavigationController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
