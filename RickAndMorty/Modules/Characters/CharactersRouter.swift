//
//  CharactersRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

protocol CharactersRoutingLogic {
    func showDetailsCharacter(character: DetailCharacter)
}

protocol CharactersDataPassingProtocol {
    var dataStore: CharactersStoreProtocol? { get set }
}

protocol URLPassingProtocol {
    var urlStore: URLStoreProtocol? { get set }
}

protocol FilterURLPassingProtocol {
    var filterURLStore: FilterURLStoreProtocol? { get set }
}

protocol FilterTransferProtocol {
    func  showFilterViewController()
}

class CharactersRouter: NSObject, CharactersRoutingLogic, CharactersDataPassingProtocol, URLPassingProtocol, FilterTransferProtocol, FilterURLPassingProtocol {
    
    
    // MARK: Properties
    var urlStore: URLStoreProtocol?
    var dataStore: CharactersStoreProtocol?
    var filterURLStore: FilterURLStoreProtocol?
    weak var viewController: CharactersViewController?
    
    // MARK: Routing
    
    func showDetailsCharacter(character: DetailCharacter) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.DetailsStoryboard.rawValue, bundle: nil)
        guard let characterViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.DetailCharactersViewController.rawValue)  as? DetailCharactersViewController else { return }
        characterViewController.character = character
        viewController?.navigationController?.show(characterViewController, sender: true)
    }
    
    func showFilterViewController() {
        let storyboard = UIStoryboard(name: Constants.Storyboards.FilterStoryboard.rawValue, bundle: nil)
        guard let filterViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.FilterViewController.rawValue)  as? FilterViewController else { return }
        
        viewController?.navigationController?.pushViewController(filterViewController, animated: true)
        
    }
}


