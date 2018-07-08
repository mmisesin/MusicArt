//
//  UITableViewCellExtensions.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
}
