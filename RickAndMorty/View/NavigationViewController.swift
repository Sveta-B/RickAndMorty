//
//  NavigationViewController.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import UIKit

class NavigationViewController: UINavigationController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setValue(true, forKey : "hidesShadow" )
        navigationBar.barTintColor = #colorLiteral(red: 0.1491553485, green: 0.1692692935, blue: 0.2072440982, alpha: 1)
        createSearchController()
    }

    // MARK: - SearchController
    func  createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите имя"
        navigationItem.searchController = searchController
        definesPresentationContext = true
            }
}
