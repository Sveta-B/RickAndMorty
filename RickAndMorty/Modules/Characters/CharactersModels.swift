//
//  CharactersModels.swift
//  RickAndMorty
//
//  Created by Света Брасс on 16.06.21.
//

import UIKit

enum Characters {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getCharacters
                case getMoreCharacters
                case getSearchCharacters(text: String)
                case getFilterCharacters
            }
        }
        struct Response {
            enum ResponseType {
                case presentCharacters(characters: [Character])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayCharacters(charactersModel: CharactersModel)
            }
        }
    }
}
struct CharactersModel  {
    struct Cell: CharactersCollectionViewCellProtocol {
        var name: String
        var image: String?
        var status: String?
        var gender: String
        var species: String?
    }
    var cells: [Cell]
    
}


