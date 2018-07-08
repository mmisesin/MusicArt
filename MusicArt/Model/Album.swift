//
//  Album.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    var playcount: Int
    var image: [Image]
    var name: String
    
}
