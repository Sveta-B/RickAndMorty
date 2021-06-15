//
//  EpisodesInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 14.06.21.
//

import Foundation

protocol EpisodesInteractorProtocol: class {
    func fetchEpisodes()
}

class EpisodesInteractor: EpisodesInteractorProtocol {
    
    var presenter: EpisodesPresenterProtocol?
    var networkManager = NetworkManager()
    var episodesData: EpisodeData?
    
    
    func fetchEpisodes() {
      
        networkManager.getData(nameSection: .episode, typeResult: episodesData, pageNumber: 1) { [weak self](result) in
            
            switch result {
            case .success(let data):
                self?.presenter?.presentData(data: data!)
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    
}
