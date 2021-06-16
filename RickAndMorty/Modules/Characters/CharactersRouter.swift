//
//  CharactersRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharactersRoutingLogic {
    func showDetailsCharacter(character: DetailCharacter)
}


class CharactersRouter: NSObject, CharactersRoutingLogic {

  weak var viewController: CharactersViewController?
  
  // MARK: Routing
    func showDetailsCharacter(character: DetailCharacter) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.DetailsStoryboard.rawValue, bundle: nil)
        guard let characterViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.DetailCharactersViewController.rawValue)  as? DetailCharactersViewController else { return }
        characterViewController.router?.dataStore?.name = character.name
        viewController?.navigationController?.show(characterViewController, sender: true)
                }
}
