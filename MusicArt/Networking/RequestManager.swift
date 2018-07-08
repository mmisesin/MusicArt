//
//  RequestManager.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

class Dispatcher {
    
    private let request: Router
    
    init(request: Router) {
        self.request = request
    }
    
    func sendRequest() {
        do {
            let urlRequest = try request.asURLRequest()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

class RequestManager {
    
    static func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    static func sendRequest(of type: Router, completion: @escaping (Result<>))
    
}
