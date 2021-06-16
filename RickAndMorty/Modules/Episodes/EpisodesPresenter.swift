//
//  EpisodesPresenter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EpisodesPresentationLogic {
  func presentData(response: Episodes.Model.Response.ResponseType)
}

class EpisodesPresenter: EpisodesPresentationLogic {
  
  weak var viewController: EpisodesDisplayLogic?
  
  func presentData(response: Episodes.Model.Response.ResponseType) {
    switch response {
    
    case .presentEpisodes(episode: let episode):
        
        let cells = episode.map{ (episode) in
            cellViewModel(from: episode)
        }
       
        
        let episodeModel = EpisodesModel.init(cells: cells)
        
        viewController?.displayData(viewModel: .displayEpisodes(episodeModel: episodeModel))
    }
  }
    func cellViewModel(from episodes: Episode) -> EpisodesModel.Cell {
        return EpisodesModel.Cell.init(characters: episodes.characters, date: episodes.airDate, number: episodes.episode, name: episodes.name ?? "No name")
            
            
    }
  
}
