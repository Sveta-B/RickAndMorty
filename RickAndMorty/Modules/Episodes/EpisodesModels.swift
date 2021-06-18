//
//  EpisodesModels.swift
//  RickAndMorty
//
//  Created by Света Брасс on 15.06.21.
//

import UIKit

enum Episodes {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getEpisodes
        case getMoreEpisodes
      }
    }
    struct Response {
      enum ResponseType {
        case presentEpisodes(episode: [Episode])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayEpisodes(episodeModel: EpisodesModel)
      }
    }
  }
}

struct EpisodesModel {
    struct Cell: EpisodesViewCellProtocol {
        var characters: [String]?
        var date: String?
        var number: String?
        var name: String
    
    }
    var cells: [Cell]
}

