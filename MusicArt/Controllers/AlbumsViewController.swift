//
//  AlbumsViewController.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/7/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

//MARK: - AlbumsViewController (Private helpers)

private extension AlbumsViewController {
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search album"
        navigationItem.searchController = searchController
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
}

// MARK: - AlbumsViewController (UISearchResultsUpdating)

extension AlbumsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text
    }
    
}

// MARK: - AlbumsViewController (UISearchBarDelegate)

extension AlbumsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
}
