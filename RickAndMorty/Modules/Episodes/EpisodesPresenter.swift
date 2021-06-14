//
//  EpisodesPresenter.swift
//  RickAndMorty
//
//  Created by Света Брасс on 14.06.21.
//

import Foundation

protocol EpisodesPresenterProtocol {
    init(viewController: EpisodesCollectionViewProtocol)
    func presentData(data: EpisodeData)
}

class EpisodesPresenter: EpisodesPresenterProtocol {
    
    
    private var episodes: [Episode]?
    var viewController: EpisodesCollectionViewProtocol?
    required init(viewController: EpisodesCollectionViewProtocol) {
        self.viewController = viewController
    }
    func presentData(data: EpisodeData) {
        if let result = data.results {
        viewController?.displayData(data: result )
        print(data)
        }
    }
    
    
}
