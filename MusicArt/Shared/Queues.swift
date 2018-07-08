//
//  Queues.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

struct Queues {
    static var Main: DispatchQueue { return DispatchQueue.main }
    
    static func executeOnMain(execute work: @escaping @convention(block) () -> Swift.Void) {
        guard !Thread.isMainThread else {
            work()
            return
        }
        
        Queues.Main.async(execute: work)
    }
}
