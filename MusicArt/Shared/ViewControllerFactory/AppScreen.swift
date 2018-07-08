//
//  AppScreen.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

enum AppScreen {
    case albumsList(title: String)
    case albumDetails(metaDataEntry: AlbumMetadataEntry)
}

// MARK: - Screen (Storyboard)

extension AppScreen {
    var storyboard: Storyboard {
        switch self {
        case .albumsList, .albumDetails:
            return .main
        }
    }
}

//MARK: - Screen (ViewController Type)

extension AppScreen {
    var controllerType: UIViewController.Type {
        switch self {
        case .albumsList:
            return AlbumsViewController.self
        case .albumDetails:
            return AlbumDetailsViewController.self
        }
    }
}

// MARK: - Storyboard

enum Storyboard {
    case main
}

// MARK: - Storyboard (Name)

extension Storyboard {
    var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }
}
