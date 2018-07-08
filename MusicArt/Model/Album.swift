//
//  Album.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    var title: String?
    var tracks: [Track]
    var playcountNumber: Int?
    var listenersNumber: Int?
    var coverImageUrl: String?
    
}
