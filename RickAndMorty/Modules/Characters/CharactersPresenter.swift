//
//  CharactersPresenter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21."
//

import UIKit

protocol CharactersPresentationLogic {
  func presentData(response: Characters.Model.Response.ResponseType)
}

class CharactersPresenter: CharactersPresentationLogic {
    
    // MARK: Properties
    
  weak var viewController: CharactersDisplayLogic?

    // MARK: CharactersPresentationLogic
    
  func presentData(response: Characters.Model.Response.ResponseType) {
    switch response {
   
    case .presentCharacters(characters: let characters):
        let cells = characters.map { (character)  in
            cellViewModel(from: character)
        }
            let characterModel = CharactersModel.init(cells: cells)
        viewController?.displayData(viewModel: .displayCharacters(charactersModel: characterModel))
            
    
    }
  }
    
    func cellViewModel(from characters: Character) -> CharactersModel.Cell {
        return CharactersModel.Cell.init(name: characters.name ?? "No name", image: characters.image, status: characters.status.map { $0.rawValue }, gender: characters.gender.map { $0.rawValue }, species: characters.species)

    }
  

}
