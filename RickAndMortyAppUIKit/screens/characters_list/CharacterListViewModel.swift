//
//  CharacterListViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation
import Alamofire

class CharacterListViewModel: ObservableObject {
    
    @Published var characters: [CharacterModel] = []
    @Published var loading: Bool = false
    let apiClient = ApiClient()
    
    func getCharacters() {
        self.loading = true
        apiClient.charactersRequest { [weak self] characterDTO in
            let characters = characterDTO.results.map { character in
                CharacterModel(name: character.name, image: character.image, status: character.status)
            }
            self?.characters = characters
            self?.loading = false
        } failure: { error in
            print("error")
        }
    }
}
