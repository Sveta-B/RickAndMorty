//
//  ChooseSectionRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.06.21.
//

import UIKit

protocol ChooseSectionRoutingLogic {

    func sendingURL(url: String, name: String)
}


class ChooseSectionRouter: NSObject, ChooseSectionRoutingLogic {
    
    // MARK: Properties
    
    weak var viewController: ChooseSectionViewController?
    
    
    // MARK: ChooseSectionRoutingLogic
    
    func sendingURL(url: String, name: String) {
     
        if name == "Characters" {
            let storyboard = UIStoryboard(name: Constants.Storyboards.CharactersStoryboard.rawValue, bundle: nil)
            guard let secondViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.CharactersViewController.rawValue)  as? CharactersViewController else { return }
                    secondViewController.modalPresentationStyle = .fullScreen
            viewController?.navigationController?.pushViewController(secondViewController, animated: true)
            secondViewController.router?.urlStore?.stringURL = url
        } else if name == "Locations" {
            print(name)
            let storyboard = UIStoryboard(name: Constants.Storyboards.LocationsStoryboard.rawValue, bundle: nil)
            guard let secondViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.LocationsViewController.rawValue)  as? LocationsViewController else { return }
                    secondViewController.modalPresentationStyle = .fullScreen
            viewController?.navigationController?.pushViewController(secondViewController, animated: true)
            secondViewController.router?.urlStore?.stringURL = url
        } else {
            let storyboard = UIStoryboard(name: Constants.Storyboards.EpisodesStoryboard.rawValue, bundle: nil)
            guard let secondViewController = storyboard.instantiateViewController(identifier: Constants.IdRootViewControllers.EpisodesViewController.rawValue)  as? EpisodesViewController else { return }
                    secondViewController.modalPresentationStyle = .fullScreen
            viewController?.navigationController?.pushViewController(secondViewController, animated: true)
            secondViewController.router?.urlStore?.stringURL = url
        }
    }
}
