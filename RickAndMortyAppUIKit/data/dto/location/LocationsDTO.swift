//
//  LocationsDTO.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation

struct LocationsDTO: Codable {
    let info: Info
    let results: [LocationDTO]
}
