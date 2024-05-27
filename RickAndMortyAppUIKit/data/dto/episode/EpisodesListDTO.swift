//
//  EpisodesDTO.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation

struct EpisodesListDTO: Codable {
    let info: Info
    let results: [EpisodeDTO]
}
