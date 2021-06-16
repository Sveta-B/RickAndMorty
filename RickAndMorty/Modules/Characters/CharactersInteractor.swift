//
//  CharactersInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

protocol CharactersBusinessLogic {
  func makeRequest(request: Characters.Model.Request.RequestType)
}

class CharactersInteractor: CharactersBusinessLogic {

  var presenter: CharactersPresentationLogic?
  var service: CharactersService?
  var characterData: CharacterData?
  var characters: [Character]?
  var networkManager: NetworkManagerProtocol?
  var pageNumber = 1
  
  func makeRequest(request: Characters.Model.Request.RequestType) {
    networkManager = NetworkManager()
    if service == nil{
      service = CharactersService()
    }
    
    switch request {
   
    case .getCharacters:
        networkManager?.getData(nameSection: .character, typeResult: characterData, pageNumber: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
             
                self?.characters = data.results
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.pageNumber = 2
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    case .getMoreCharacters:
        networkManager?.getData(nameSection: .character, typeResult: characterData, pageNumber: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.characters?.append(contentsOf:data.results)
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.pageNumber += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
  }
  
}
