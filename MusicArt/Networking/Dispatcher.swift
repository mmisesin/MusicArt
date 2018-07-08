//
//  Dispatcher.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class Dispatcher {
    
    static func sendRequest<T: Codable>(_ router: Router, type: T.Type, completion: @escaping (Result<T>) -> Void) {
        guard let request = router.urlRequest() else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            Queues.executeOnMain {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let jsonData = data else {
                    completion(.failure("No data for request"))
                    return
                }
                let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] 
                print(dict)
                do {
                    let results = try JSONDecoder().decode(type, from: jsonData)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
