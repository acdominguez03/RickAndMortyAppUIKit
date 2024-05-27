//
//  EpisodeDTO.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation
struct EpisodeDTO: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
    
    func toEpisodeModel() -> EpisodeModel {
        return EpisodeModel(
            id: id,
            name: name,
            airDate: airDate,
            episode: episode
        )
    }
}
