//
//  Section.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import Foundation

enum Sections: String {
    case character = "Characters"
    case location = "Locations"
    case episode =  "Episodes"
}
struct Section {
    let name: Sections
    let image: Sections
}
