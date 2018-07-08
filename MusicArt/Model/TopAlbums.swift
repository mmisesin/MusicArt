//
//  TopAlbums.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct AlbumsEntry: Codable {
    
    var topAlbums: TopAlbums
    
    enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
    
}

extension AlbumsEntry {
    
    struct TopAlbums: Codable {
        
        var albums: [Album]
        
        enum CodingKeys: String, CodingKey {
            case albums = "album"
        }
        
    }
    
}
