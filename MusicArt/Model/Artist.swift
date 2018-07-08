//
//  Artist.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct Artist: Codable {
    
    var name: String?
    var albums: [Album]
    
}
