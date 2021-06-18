//
//  ChooseSectionInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.06.21.
//

import UIKit

protocol ChooseSectionBusinessLogic {
  func makeRequest(request: ChooseSection.Model.Request.RequestType)
}

class ChooseSectionInteractor: ChooseSectionBusinessLogic {
    
    // MARK: Properties
    
    let baseURL = "https://rickandmortyapi.com/api/"
    var sectionsURL = Sections(characters: "", locations: "", episodes: "")
    var presenter: ChooseSectionPresentationLogic?
    var networkManager: NetworkManagerProtocol?
  
    // MARK: ChooseSectionBusinessLogic
    
  func makeRequest(request: ChooseSection.Model.Request.RequestType) {
    switch request {
    
    case .getSections:
        networkManager?.fetchData(stringURL: baseURL, typeResult: sectionsURL)
        { (url) in
            url.map { (section)  in
                guard let characters = section?.characters else  { return }
                guard let locations = section?.locations else  { return }
                guard let episodes = section?.episodes else  { return }
                self.presenter?.presentData(response: .presentSections(characters: characters, locations: locations, episodes: episodes))
            }
        }
    }
  }
}
