//
//  DetailCharactersModels.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

enum DetailCharacters {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getCharacter
      }
    }
    
    struct ViewModel {
      enum ViewModelData {
        case displayCharacters(characterModel: DetailCharacter)
      }
    }
  }
  
}
struct DetailCharacter: Equatable  {
        var name: String
        var image: String?
        var status: String?
        var gender: String?
        var species: String?
    }
