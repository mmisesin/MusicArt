//
//  Image.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

struct Image: Codable {
    
    var url: String
    var size: String
    
    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }
}
