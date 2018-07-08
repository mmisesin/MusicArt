//
//  AlbumDetailsViewController.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController, LoadingIndicatorPresenter {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let backgroundCoverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var isNavigationHidden = false
    
    var albumName: String?
    var artistName: String?
    
    var albumEntry: AlbumMetadataEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        self.updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

// MARK: - AlbumDetailsViewController (Private helpers)

private extension AlbumDetailsViewController {
    
    func setupUI() {
        artistNameLabel.adjustsFontSizeToFitWidth = true
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        toggleNavigationBar(hidden: true)
        
    }
    
    func updateUI() {
        Queues.executeOnMain {
            self.tableView.reloadData()
        }
    }
    
    func toggleNavigationBar(hidden: Bool) {
        if !hidden {
            navigationController?.view.backgroundColor = .lightGray
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.tintColor = .black
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.view.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .white
        }
    }
    
}

// MARK: - AlbumsViewController (UITableViewDataSource)

extension AlbumDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = albumEntry?.album.trackList.tracks.count else {
            return 0
        }
        return count + 2
    }
    
    // something went wrong here and begs for refactoring
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let album = albumEntry?.album else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: AlbumCoverTableViewCell.reuseId, for: indexPath)
            if let headerCell = cell as? AlbumCoverTableViewCell {
                headerCell.setWith(album)
            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: AlbumHeaderTableViewCell.reuseId, for: indexPath)
            if let headerCell = cell as? AlbumHeaderTableViewCell {
                headerCell.setWith(album)
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseId, for: indexPath)
            if let trackCell = cell as? TrackTableViewCell {
                trackCell.setWith(album.trackList.tracks[indexPath.row - 2])
            }
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        print(offset)
        
        if offset >= 30 {
            toggleNavigationBar(hidden: false)
        } else {
            toggleNavigationBar(hidden: true)
        }
    }
    
}
