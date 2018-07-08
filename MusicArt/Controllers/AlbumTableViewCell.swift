//
//  AlbumTableViewCell.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/7/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var albumTitleLabel: UILabel!
    @IBOutlet private var listenersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
