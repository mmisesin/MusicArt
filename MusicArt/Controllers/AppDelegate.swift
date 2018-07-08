//
//  AppDelegate.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/7/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {
            preconditionFailure("No window located")
            return false
        }
        LoadingIndicatorWrapper.setupAppearance(withSuperview: window)
        return true
    }

}

