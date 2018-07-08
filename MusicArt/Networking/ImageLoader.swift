//
//  ImageLoader.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class ImageLoader {
    
    static private func downloadedFrom(url: URL, callback: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    callback(UIImage())
                    return
            }
            callback(image)
            }.resume()
    }
    
    static func downloadedFrom(link: String, callback: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url) { image in
            callback(image)
        }
    }
    
}
