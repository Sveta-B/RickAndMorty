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

protocol CharactersStoreProtocol {
    var charactersURL: [String]? { get set }
}

class CharactersInteractor: CharactersBusinessLogic,  CharactersStoreProtocol {
    var charactersURL: [String]? 
    
    

    private var stringURL = "https://rickandmortyapi.com/api/character"
    private var characterData: CharacterData?
    private var characters: [Character]?
  var networkManager: NetworkManagerProtocol?
  var presenter: CharactersPresentationLogic?
  
  func makeRequest(request: Characters.Model.Request.RequestType) {
    networkManager = NetworkManager()
    
    switch request {
   
    case .getCharacters:
        networkManager?.fetchData(stringURL: stringURL, typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.characters = data.results
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.stringURL = data.info.next ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    case .getMoreCharacters:
        networkManager?.fetchData(stringURL: stringURL, typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.characters?.append(contentsOf:data.results)
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.stringURL = data.info.next ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    case .getStringURLCharacters:
        print(charactersURL)
    }
  }
  
}
