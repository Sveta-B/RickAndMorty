//
//  Character.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import Foundation


// MARK: - CharacterData
struct CharacterData: Codable {
    let info: InfoCharacters
    let results: [Character]
}

// MARK: - Info
struct InfoCharacters: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: Gender
    let image: String
    let url: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

