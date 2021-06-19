//
//  LocationData.swift
//  RickAndMorty
//
//  Created by Света Брасс on 20.05.21.
//

import Foundation

struct LocationData: Codable {
    let info: InfoLocation
    let results: [Location]
}

    struct InfoLocation: Codable {
        let count, pages: Int
        let next: String
    }
    
    struct Location: Codable {
        let id: Int
        let name, type, dimension: String?
        let residents: [String]?
        }


