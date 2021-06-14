//
//  SearchControllerExtention.swift
//  RickAndMorty
//
//  Created by Света Брасс on 14.06.21.
//

import UIKit

extension CharactersCollectionViewController: UISearchResultsUpdating {

// MARK: - SearchController
public func  createSearchController() {
    searchController.loadViewIfNeeded()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Введите имя"
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.enablesReturnKeyAutomatically = false
    searchController.searchBar.returnKeyType = .done
    navigationItem.searchController = searchController
    definesPresentationContext = true
    navigationItem.hidesSearchBarWhenScrolling = false
        }


func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else {
        return
    }
    
    searchBar(searchController.searchBar, textDidChange: text)
    
}
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            searchCharacters = characters
            collectionView.reloadData()
        } else {
            self.filterTableView(text: searchText)
        
        }
    }

func filterTableView(text:String) {
   
    searchCharacters = characters?.filter( { character in
       
        let searchTextIsMatch =  (character.name?.lowercased().contains(text.lowercased()))
        return searchTextIsMatch ?? false
    })
    
    
    self.collectionView.reloadData()
}

}
