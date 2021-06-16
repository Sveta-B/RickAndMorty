//
//  DetailCharactersInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

protocol DetailCharactersBusinessLogic {
  func makeRequest(request: DetailCharacters.Model.Request.RequestType)
}

protocol DetailCharactersStoreProtocol: class {
    var name: String { get set }
    var image: String? { get set }
    var status: String? { get set }
    var gender: String? { get set }
    var species: String? { get set }
    
}

class DetailCharactersInteractor: DetailCharactersBusinessLogic, DetailCharactersStoreProtocol {
    var name: String = "rr"
    var image: String?
    var status: String?
    var gender: String?
    var species: String?
    
    weak var viewController: DetailCharactersDisplayLogic?
  func makeRequest(request: DetailCharacters.Model.Request.RequestType) {
    
    switch request {
    
    case .getCharacter:
        print(name)
        viewController?.displayData(viewModel: .displayCharacters(characterModel: DetailCharacter(name: name, image: image, status: status, gender: gender, species: species)))
       
      
    }
    
  }
  
}
