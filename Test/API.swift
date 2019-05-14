//
//  API.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation

struct API {
    
    static func getRestaurants(completion: @escaping ([Restaurant], String?) -> ()) {
        
        guard let URL = URL(string: Constants.url) else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                if let data = data, statusCode == 200 {
                    
                    do {
                        let decoder = JSONDecoder()
                        let restaurantResponse = try decoder.decode(GetRestaurantResponse.self, from: data)
                        return completion(restaurantResponse.restaurants, nil)
    
                    } catch let err {
                        print(err)
                        return completion([Restaurant](), err.localizedDescription)
                    }
                }
            }
            else {
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            
            completion([Restaurant](), error?.localizedDescription ?? "response code was not 200")
        })
        
        task.resume()
    }
}
