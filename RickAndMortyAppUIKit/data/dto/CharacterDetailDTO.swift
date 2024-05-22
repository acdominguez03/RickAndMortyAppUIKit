//
//  CharacterDetailDTO.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

class CharacterDetailDTO: Codable {
    let id: Int
    let name, species, type: String
    let status: Status
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    
    func toCharacterDetailModel() -> CharacterDetailModel {
        return CharacterDetailModel(
            id: self.id,
            name: self.name,
            image: self.image,
            location: self.location.name,
            origin: self.origin.name,
            status: self.status.rawValue,
            type: self.type,
            species: self.species
        )
    }
}
