//
//  Router.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Alamofire

enum Router {
    
    struct Constants {
        static let baseURL = "http://ws.audioscrobbler.com/2.0/"
        static let apiKey = "22f54e267ea5021860c1759bd9ccd8e7"
    }
    
    case getAlbums
    case getAlbumTracks
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAlbums,
             .getAlbumTracks:
            return .get
        }
    }
    
    var path: String {
        switch self {
            case .getAlbums,
                 .getAlbumTracks:
            return ""
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getAlbums,
             .getAlbumTracks:
            return [:]
        }
    }
    
    func urlRequest() throws -> URLRequest {
        let url = URL(string: Constants.baseURL)
        
        var urlRequest: URLRequest
        guard let unwrappedUrl = url else {
            throw "Invalid URL"
        }
        
        if path.isEmpty {
            urlRequest = URLRequest(url: unwrappedUrl)
        } else {
            urlRequest = URLRequest(url: unwrappedUrl.appendingPathComponent(path))
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        switch self {
        case .getAlbums:
            
        case .getAlbumTracks:
            
        }
        
    }
    
}
