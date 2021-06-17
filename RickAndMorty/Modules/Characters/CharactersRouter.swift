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





class CharactersRouter: NSObject, CharactersRoutingLogic, CharactersDataPassingProtocol {
    
    var dataStore: CharactersStoreProtocol?
    
    
  weak var viewController: CharactersViewController?
  
  // MARK: Routing
    func showDetailsCharacter(character: DetailCharacter) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.DetailsStoryboard.rawValue, bundle: nil)
        guard let characterViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.DetailCharactersViewController.rawValue)  as? DetailCharactersViewController else { return }
        characterViewController.character = character
        viewController?.navigationController?.show(characterViewController, sender: true)
                }
}
