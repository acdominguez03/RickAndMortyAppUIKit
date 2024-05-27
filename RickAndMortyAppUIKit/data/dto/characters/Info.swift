//
//  Info.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}
