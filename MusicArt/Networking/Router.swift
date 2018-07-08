//
//  Router.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

enum Router {
    
    struct Constants {
        static let scheme = "http"
        static let baseURL = "ws.audioscrobbler.com"
        static let apiKey = "22f54e267ea5021860c1759bd9ccd8e7"
        static let format = "json"
    }
    
    case getTopAlbums(name: String)
    case getAlbumInfo(artistName: String, albumName: String)
    
    var path: String {
        return "/2.0"
    }
    
    var method: String {
        switch self {
        case .getTopAlbums,
             .getAlbumInfo:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        switch self {
        case .getTopAlbums(let name):
            items.append(URLQueryItem(name: "method", value: "artist.gettopalbums"))
            items.append(URLQueryItem(name: "artist", value: name))
        case .getAlbumInfo(let artistName, let albumName):
            items.append(URLQueryItem(name: "method", value: "album.getInfo"))
            items.append(URLQueryItem(name: "artist", value: artistName))
            items.append(URLQueryItem(name: "album", value: albumName))
        }
                
        items.append(URLQueryItem(name: "api_key", value: Constants.apiKey))
        items.append(URLQueryItem(name: "format", value: Constants.format))
        return items
    }
    
    func urlRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.baseURL
        urlComponents.path = path
        urlComponents.queryItems = self.queryItems
        guard let url = urlComponents.url else {
            preconditionFailure("Could not create URL for components")
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        return urlRequest
        
    }
    
}
