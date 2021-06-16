//
//  EpisodesInteractor.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EpisodesBusinessLogic {
  func makeRequest(request: Episodes.Model.Request.RequestType)
}

class EpisodesInteractor: EpisodesBusinessLogic {

  var presenter: EpisodesPresentationLogic?
  var service: EpisodesService?
    var episodeData: EpisodeData?
        var episodes: [Episode]?
        var networkManager: NetworkManagerProtocol?
        var pageNumber = 1
  func makeRequest(request: Episodes.Model.Request.RequestType)
  
  {
    networkManager = NetworkManager()
    if service == nil{
      service = EpisodesService()
    }
    switch request {
    
    case .getEpisodes:
        networkManager?.getData(nameSection: .episode, typeResult: episodeData, pageNumber: pageNumber)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.episodes = data.results
                self?.presenter?.presentData(response: .presentEpisodes(episode: self?.episodes ?? []))
                self?.pageNumber = 2
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    case .getMoreEpisodes:
        networkManager?.getData(nameSection: .episode, typeResult: episodeData, pageNumber: pageNumber)
        { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.episodes?.append(contentsOf: data.results ?? [])
               
                self?.presenter?.presentData(response: .presentEpisodes(episode: self?.episodes ?? []))
                self?.pageNumber += 1
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        }
    
  }
  
}
