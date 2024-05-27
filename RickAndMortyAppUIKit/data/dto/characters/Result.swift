//
//  Result.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

struct Result: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    func toCharacterModel() -> CharacterModel {
        return CharacterModel(
            id: self.id,
            name: self.name,
            image: self.image,
            status: self.status.rawValue
        )
    }
}
