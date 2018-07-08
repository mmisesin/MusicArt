//
//  ViewControllerFactory.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    static func createController(from screen: AppScreen) -> UIViewController {
        let controller = configuredController(from: screen)
        return controller
    }
    
    private static func configuredController(from screen: AppScreen) -> UIViewController {
        var controller: UIViewController = UIViewController()
        if screen.storyboard != .none {
            controller = createViewController(ofType: screen.controllerType, from: screen.storyboard)
        }
        
        switch screen {
        case .albumDetails(let entry):
            configure(albumDetailsViewController: controller, metaDataEntry: entry)
        default:
            return UIViewController()
        }
        
        return controller
    }
}

// MARK: - ViewControllerFactory (Private configuration)

private extension ViewControllerFactory {
    static func configure(albumDetailsViewController controller: UIViewController, metaDataEntry: AlbumMetadataEntry) {
        guard let albumDetailsViewController = controller as? AlbumDetailsViewController else {
            preconditionFailure("Wrong controller")
            return
        }
        
        albumDetailsViewController.albumEntry = metaDataEntry
    }
}

// MARK: - ViewControllerFactory (Private create)

private extension ViewControllerFactory {
    static func createViewController<T: UIViewController>(ofType controllerType: T.Type, from storyboard: Storyboard) -> T {
        // TODO: think how to avoid force crash and present something meaningful to the user
        guard storyboard != .none else {
            preconditionFailure("Attempt to instantiate viewcontoller of type \(controllerType) which is not based on any Storyboard")
        }
        
        let storyboardId = UIViewController.storyboardId(for: controllerType)
        
        // TODO: same as above
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else {
            preconditionFailure("Failed to instantiate viewcontroller of type \(controllerType) from storyboard \(storyboard.name)")
        }
        
        return controller
    }
}

// MARK: - UIViewController (Storyboard ID)

private extension UIViewController {
    static func storyboardId<T: UIViewController>(for controllerType: T.Type) -> String {
        let id = String(describing: controllerType)
        return id
    }
}

// MARK: - Storyboard (Instantiating)

private extension Storyboard {
    func instantiateViewController(withIdentifier storyboardId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: self.name, bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return controller
    }
}
