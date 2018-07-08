//
//  AlbumsViewController.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/7/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController, LoadingIndicatorPresenter {
    
    let artistName = "Kendrick Lamar"
    
    @IBOutlet private var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var albums: [Album] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var filteredAlbums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearch()
        setupTableView()
        fetchAlbums()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllCells()
    }

}

//MARK: - AlbumsViewController (Private helpers)

private extension AlbumsViewController {
    
    func deselectAllCells() {
        Queues.executeOnMain {
            if let index = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: index, animated: false)
            }
        }
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = artistName
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search album"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    func fetchAlbums() {
        let router = Router.getTopAlbums(name: artistName)
        Dispatcher.sendRequest(router, type: AlbumsEntry.self) { (result) in
            switch result {
            case .success(let object):
                self.albums = object.topAlbums.albums
            case .failure(let error):
                self.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func getMetaData(forAlbumNamed name: String, callback: @escaping (AlbumMetadataEntry?) -> Void) {
        Queues.executeOnMain {
            self.displayLoadingIndicator()
        }
        let router = Router.getAlbumInfo(artistName: artistName, albumName: name)
        
        Dispatcher.sendRequest(router, type: AlbumMetadataEntry.self) { (result) in
            Queues.executeOnMain {
                self.hideLoadingIndicator()
            }
            switch result {
            case .success(let object):
                callback(object)
            case .failure(let error):
                self.showAlert(with: error.localizedDescription)
                callback(nil)
            }
        }
    }
    
    func updateFilteredResults(_ searchText: String) {
        filteredAlbums = albums.filter({ (album) -> Bool in
            return album.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    func setupBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
}

// MARK: - AlbumsViewController (UITableViewDataSource)

extension AlbumsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching() {
            return filteredAlbums.count
        } else {
            return albums.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseId, for: indexPath)
        
        if let albumCell = cell as? AlbumTableViewCell {
            var album: Album
            if isSearching() {
                album = filteredAlbums[indexPath.row]
            } else {
                album = albums[indexPath.row]
            }
            
            albumCell.setWith(album)
        }
        
        return cell
    }
    
}

// MARK: - AlbumsViewController (UITableViewDelegate)

extension AlbumsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var albumName: String
        if isSearching() {
          albumName = filteredAlbums[indexPath.row].name
        } else {
          albumName = albums[indexPath.row].name
        }
        getMetaData(forAlbumNamed: albumName) { (entry) in
            guard let entry = entry else {
                return
            }
            Queues.executeOnMain {
                let vc = ViewControllerFactory.createController(from: .albumDetails(metaDataEntry: entry))
                
                self.setupBackButton()
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

// MARK: - AlbumsViewController (UISearchResultsUpdating)

extension AlbumsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        updateFilteredResults(searchController.searchBar.text ?? "")
    }
    
}

// MARK: - AlbumsViewController (UISearchBarDelegate)

extension AlbumsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
