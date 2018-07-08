//
//  AlbumTableViewCell.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/7/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverContainerView: UIView!
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var albumTitleLabel: UILabel!
    @IBOutlet private var playcountLabel: UILabel!
    @IBOutlet weak var coverActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setWith(_ album: Album) {
        albumTitleLabel.text = album.name
        playcountLabel.text = "\(album.playcount)"
        coverImageView.image = UIImage()
        coverActivityIndicator.startAnimating()
        if let thumbnail = album.image.first(where: {$0.size == Constants.ImageSize.medium}) {
            ImageLoader.downloadedFrom(link: thumbnail.url) { (image) in
                Queues.executeOnMain {
                    self.coverActivityIndicator.stopAnimating()
                    self.coverImageView.image = image
                }
            }
        }
    }
    
    private func setupUI() {
        coverContainerView.backgroundColor = .clear
        coverContainerView.layer.shadowColor = UIColor.black.cgColor
        coverContainerView.layer.shadowOpacity = 0.5
        coverContainerView.layer.shadowOffset = CGSize.zero
        coverContainerView.layer.shadowRadius = 5
        coverContainerView.layer.shadowPath = UIBezierPath(roundedRect: coverContainerView.bounds, cornerRadius: 10).cgPath
    }
}
