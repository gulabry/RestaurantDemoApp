//
//  Restaurant.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation

struct GetRestaurantResponse: Decodable {
    var restaurants: [Restaurant]
}

struct Restaurant: Decodable {
    var name: String
    var backgroundImageURL: String
    var category: String
    var contact: Contact?
    var location: Location
}

struct Contact: Decodable {
    var phone: String
    var formattedPhone: String
    var twitter: String?
    var facebook: String?
    var facebookUsername: String?
    var facebookName: String?
}

struct Location: Decodable {
    var address: String
    var crossStreet: String?
    var lat: Double
    var lng: Double
    var postalCode: String?
    var cc: String
    var city: String
    var state: String
    var country: String
    var formattedAddress: [String]
}
