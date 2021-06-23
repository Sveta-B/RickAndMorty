//
//  CustomSearchBar.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.06.21.
//

import UIKit

class CustomSearchController: UISearchController {
    
    var viewController: (ParentCollectionViewController & CharactersDisplayLogic & UISearchBarDelegate & UISearchResultsUpdating)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        searchResultsUpdater = viewController
        searchBar.placeholder =  "Введите имя"
        automaticallyShowsScopeBar = false
        obscuresBackgroundDuringPresentation = false
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .done
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
