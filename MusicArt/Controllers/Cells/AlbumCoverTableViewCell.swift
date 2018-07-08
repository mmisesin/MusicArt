//
//  AlbumCoverTableViewCell.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/9/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumCoverTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setWith(_ metaData: AlbumMetadata) {
        Queues.executeOnMain {
            self.artistLabel.text = metaData.artist
        }
        if let cover = metaData.images.first(where: {$0.size == Constants.ImageSize.mega}) {
            self.activityIndicator.startAnimating()
            ImageLoader.downloadedFrom(link: cover.url) { (image) in
                Queues.executeOnMain {
                    self.activityIndicator.stopAnimating()
                    self.backgroundImageView.image = image
                }
            }
        }
    }
    
    private func setupUI() {
        artistLabel.adjustsFontSizeToFitWidth = true
    }
}
