//
//  EpisodeData.swift
//  RickAndMorty
//
//  Created by Света Брасс on 28.05.21.
//

import Foundation


struct EpisodeData: Codable {
    let info: InfoEpisode?
    let results: [Episode]?
}

// MARK: - Info
struct InfoEpisode: Codable {
    let count, pages: Int
    let next: String?
}

// MARK: - Result
struct Episode: Codable {
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

