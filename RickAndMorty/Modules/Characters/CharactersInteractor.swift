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
protocol URLStoreProtocol {
    var stringURL: String? { get set }
}


class CharactersInteractor: CharactersBusinessLogic,  CharactersStoreProtocol, URLStoreProtocol {
   
    // MARK: Properties
    
    private var characterData: CharacterData?
    private var characters = [Character]()
    private var character: Character?
    var charactersURL: [String]?
    var stringURL: String?
    var networkManager: NetworkManagerProtocol?
    var presenter: CharactersPresentationLogic?
  
    // MARK: CharactersBusinessLogic
    
  func makeRequest(request: Characters.Model.Request.RequestType) {
   
    switch request {
   
    case .getCharacters:
        if charactersURL != nil {
            for url in charactersURL! {
            networkManager?.fetchData(stringURL: url, typeResult: character) { [weak self](result) in
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self?.characters.append(data)
                        self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                   
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            }
        } else { characters.removeAll()
            networkManager?.fetchData(stringURL: stringURL ?? "", typeResult: characterData) { [weak self] (result) in
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
        }
        
    case .getMoreCharacters:
        
        networkManager?.fetchData(stringURL: stringURL ?? "", typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.characters.append(contentsOf:data.results)
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.stringURL = data.info.next ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    case .getFilterCharacters(text: let text):
        print(characters)
     characters.map { (character)  in
      
            if character.name?.lowercased().contains(text.lowercased()) == nil {
                characters.removeAll()
                characters.append(character)
            }
        
        else {
                characters.removeAll()
                networkManager?.fetchData(stringURL: stringURL ?? "", typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                data.results.map { (character)  in
                    if character.name?.lowercased().contains(text.lowercased()) != nil {
                        self?.characters.append(character)

                    }
                }
                
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.stringURL = data.info.next ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
                }
        }
    }
    }
}
}

