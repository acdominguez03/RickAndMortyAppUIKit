//
//  CharacterModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 21/5/24.
//

import Foundation

enum Status: String {
    case Alive
    case Dead
    case Unknown
}

struct CharacterModel {
    let name: String
    let image: String
    let status: Status
}
