//
//  ChooseSectionModels.swift
//  RickAndMorty
//
//  Created by Света Брасс on 18.06.21.
//

import UIKit

enum ChooseSection {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getSections
            }
        }
        struct Response {
            enum ResponseType {
                case presentSections(characters: String, locations: String, episodes: String)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case  displaySections(sections: [Section])
            }
        }
    }
}

struct Sections: Codable {
    let characters, locations, episodes: String
}

struct Section {
    let name: String
    let url: String
}

