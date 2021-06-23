//
//  EpisodesRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol EpisodesRoutingLogic {
    func navigateCharacters(characters: [String])
}

class EpisodesRouter: NSObject, EpisodesRoutingLogic, URLPassingProtocol {
    
    // MARK: Properties
    
    var urlStore: URLStoreProtocol?
    weak var viewController: EpisodesViewController?
    
    // MARK: Routing
    func navigateCharacters(characters: [String]) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.CharactersStoryboard.rawValue, bundle: nil)
        guard let charactersViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.CharactersViewController.rawValue)  as? CharactersViewController else { return }
        if characters.isEmpty {
            let storyboard = UIStoryboard(name: Constants.Storyboards.EmptyStoryboard.rawValue, bundle: nil)
            let charactersViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.EmptyViewController.rawValue)
            viewController?.navigationController?.show(charactersViewController, sender: nil)
            
        } else {
            charactersViewController.router?.dataStore?.charactersURLs = characters
            charactersViewController.modalPresentationStyle = .fullScreen
            viewController?.navigationController?.show(charactersViewController, sender: nil)
        }
    }
}
