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
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor  = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchBar.searchTextField.tintColor = .clear
        automaticallyShowsScopeBar = false
        obscuresBackgroundDuringPresentation = false
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .done
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
