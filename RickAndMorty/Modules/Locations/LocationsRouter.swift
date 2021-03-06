//
//  LocationsRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol LocationsRoutingLogic {
    func navigateCharacters(characters: [String])
    
}

class LocationsRouter: NSObject, LocationsRoutingLogic, URLPassingProtocol {
    
    // MARK: Properties
    
    var urlStore: URLStoreProtocol?
    weak var viewController: LocationsViewController?
    
    // MARK: Routing
    func navigateCharacters(characters: [String]) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.CharactersStoryboard.rawValue, bundle: nil)
        guard let charactersViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.CharactersViewController.rawValue)  as? CharactersViewController else { return }
        if characters.isEmpty {
            let storyboard = UIStoryboard(name: Constants.Storyboards.EmptyStoryboard.rawValue, bundle: nil)
            let emptyViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.EmptyViewController.rawValue)
            viewController?.navigationController?.show(emptyViewController, sender: nil)
            
        } else {
            charactersViewController.router?.dataStore?.charactersURLs = characters
            charactersViewController.modalPresentationStyle = .fullScreen
            viewController?.navigationController?.show(charactersViewController, sender: nil)
        }
    }
}
