//
//  CharacterListDataManager.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

class CharacterListDataManager {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getCharacters(
        success: @escaping ([CharacterModel]) -> Void,
        failure: @escaping (String) -> Void
    ) {
        apiClient.charactersRequest { charactersDTO in
            let characters = charactersDTO.results.map { character in
                character.toCharacterModel()
            }
            success(characters)
        } failure: { error in
            failure(error)
        }

    }
}
