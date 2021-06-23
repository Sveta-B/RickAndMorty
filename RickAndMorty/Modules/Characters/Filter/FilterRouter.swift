//
//  FilterRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 19.06.21.
//

import UIKit

protocol FilterRoutingLogic {
    func showFilteredCharacters()
    
}

class FilterRouter: NSObject, FilterRoutingLogic {
    
    weak var viewController: FilterViewController?
    
    // MARK: Routing
    func showFilteredCharacters()  {
        
        
        let index =  (viewController?.navigationController?.viewControllers.count ?? 0) - 2
        let destinationVC = viewController?.navigationController?.viewControllers[index]  as! CharactersViewController
        
        
        var urlComponent = URLComponents(string: "https://rickandmortyapi.com/api/character/")
        let queryItemGender = URLQueryItem(name: "gender", value: viewController?.gender)
        let queryItemStatus = URLQueryItem(name: "status", value: viewController?.status)
        urlComponent?.queryItems = [queryItemGender, queryItemStatus]
        
        destinationVC.router?.filterURLStore?.filterURL = urlComponent?.url?.absoluteString
        viewController?.navigationController?.popViewController(animated: true)
    }
}
