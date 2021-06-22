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

protocol FilterURLStoreProtocol {
    var filterURL: String? { get set }
}


class CharactersInteractor: CharactersBusinessLogic,  CharactersStoreProtocol, URLStoreProtocol, FilterURLStoreProtocol {
   
    
   
    // MARK: Properties
    
    private var characterData: CharacterData?
    private var characters = [Character]()
    private var character: Character?
    var charactersURL: [String]?
    var nextURL: String?
    var stringURL: String? {
        willSet {
            nextURL = newValue
        }
    }
    var filterURL: String? {
        willSet {
            nextURL = newValue
        }
    }
    var searchURL: String? {
        willSet {
            nextURL = newValue
        }
    }
    var networkManager: NetworkManagerProtocol?
    var presenter: CharactersPresentationLogic?
 //   var nextURL: String {
//    if stringURL != nil {
//        return stringURL ?? ""
//    } else if filterURL != nil{
//        return filterURL ?? ""
//    } else if searchURL != nil {
//        return searchURL ?? ""
//    }
//    }
  
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
        
        networkManager?.fetchData(stringURL: nextURL ?? "", typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.characters.append(contentsOf:data.results)
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.nextURL = data.info.next ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    case .getSearchCharacters(text: let text):
        var urlComponent = URLComponents(string: "https://rickandmortyapi.com/api/character/")
        let queryItemName = URLQueryItem(name: "name", value: text)
        urlComponent?.queryItems = [queryItemName]
       searchURL = urlComponent?.url?.absoluteString
        characters.removeAll()
        networkManager?.fetchData(stringURL: searchURL ?? "", typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.characters.append(contentsOf:data.results)
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.searchURL = data.info.next ?? ""
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }
  
    case .getFilterCharacters:
        guard let url = filterURL else {
            return
        }
        characters.removeAll()
            networkManager?.fetchData(stringURL: url, typeResult: characterData)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                
                self?.characters.append(contentsOf:data.results)
                self?.presenter?.presentData(response: .presentCharacters(characters: self?.characters ?? []))
                self?.filterURL = data.info.next ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
    }
    }
  }
}

