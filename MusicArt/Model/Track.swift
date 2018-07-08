//
//  Track.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct TrackEntry: Codable {
    
    var tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
    
}

struct Track: Codable {
    
    var name: String
    var duration: String
    
}

