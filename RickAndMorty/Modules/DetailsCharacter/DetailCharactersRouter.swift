//
//  DetailCharactersRouter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

protocol DetailCharactersRoutingLogic {
 
}

protocol DetailCharactersDataPassingProtocol {
    var dataStore: DetailCharactersStoreProtocol? { get }
}
class DetailCharactersRouter: NSObject, DetailCharactersRoutingLogic, DetailCharactersDataPassingProtocol {
    
    weak var dataStore: DetailCharactersStoreProtocol?
 
  // MARK: Routing
    
    }
    
  

