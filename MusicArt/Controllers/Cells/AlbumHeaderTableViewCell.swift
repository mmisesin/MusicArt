//
//  AlbumHeaderTableViewCell.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var listenersCountLabel: UILabel!
    @IBOutlet private weak var playcountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setWith(_ metaData: AlbumMetadata) {
        Queues.executeOnMain {
            self.albumNameLabel.text = metaData.name
            self.playcountLabel.text = "\(metaData.playcount)"
            self.listenersCountLabel.text = "\(metaData.listeners)"
        }
    }
    
    private func setupUI() {
        albumNameLabel.adjustsFontSizeToFitWidth = true
    }
}
