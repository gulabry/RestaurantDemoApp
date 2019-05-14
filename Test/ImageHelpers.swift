//
//  ImageHelpers.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation
import UIKit

extension URLSession {
    
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}

final class ImageManager {
    static func saveImage(image: UIImage, named: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(named)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            _ = ImageManager.saveImage(image: image, named: url.lastPathComponent)
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
