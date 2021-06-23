//
//  EpisodesInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

protocol EpisodesBusinessLogic {
    func makeRequest(request: Episodes.Model.Request.RequestType)
}

class EpisodesInteractor: EpisodesBusinessLogic, URLStoreProtocol {
    
    // MARK: Properties
    
    private var episodeData: EpisodeData?
    private var episodes: [Episode]?
    var charactersURL: String?
    var presenter: EpisodesPresentationLogic?
    var networkManager: NetworkManagerProtocol?
    
    // MARK: EpisodesBusinessLogic
    
    func makeRequest(request: Episodes.Model.Request.RequestType) {
        switch request {
        
        case .getEpisodes:
            networkManager?.fetchData(stringURL: charactersURL ?? "", typeResult: episodeData) { [weak self] (result)  in
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self?.episodes = data.results
                    self?.presenter?.presentData(response: .presentEpisodes(episode: self?.episodes ?? []))
                    self?.charactersURL = data.info?.next ?? ""
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case .getMoreEpisodes:
            networkManager?.fetchData(stringURL: charactersURL ?? "", typeResult: episodeData) { [weak self] (result)  in
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self?.episodes?.append(contentsOf: data.results ?? [])
                    self?.presenter?.presentData(response: .presentEpisodes(episode: self?.episodes ?? []))
                    self?.charactersURL = data.info?.next ?? ""
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
