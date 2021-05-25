//
//  Section.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import Foundation

struct Section {
    let name: String
    let image: String?
}

struct Api<T:Codable>: Codable {
    let info: InfoCharacters
    let results: T?
}
