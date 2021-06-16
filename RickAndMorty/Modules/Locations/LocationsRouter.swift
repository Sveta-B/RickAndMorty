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

class LocationsRouter: NSObject, LocationsRoutingLogic {
    

  weak var viewController: LocationsViewController?
  
  // MARK: Routing
    func navigateCharacters(characters: [String]) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.CharactersStoryboard.rawValue, bundle: nil)
            guard let secondViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.CharactersViewController.rawValue)  as? UICollectionViewController else { return }
           
            secondViewController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.show(secondViewController, sender: nil)
    }
    
}
