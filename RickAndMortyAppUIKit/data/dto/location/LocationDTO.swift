//
//  LocationDTO.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation

struct LocationDTO: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    func toLocationModel() -> LocationModel {
        return LocationModel(
            id: id,
            name: name,
            type: type,
            dimension: dimension
        )
    }
}
