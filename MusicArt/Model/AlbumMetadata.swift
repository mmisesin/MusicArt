//
//  AlbumMetadata.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct AlbumMetadataEntry: Codable {
    
    var album: AlbumMetadata
    
}

struct AlbumMetadata: Codable {
    
    var name: String
    var artist: String
    var playcount: String
    var listeners: String
    var trackList: TrackEntry
    var images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case playcount
        case listeners
        case trackList = "tracks"
        case images = "image"
    }
    
}
