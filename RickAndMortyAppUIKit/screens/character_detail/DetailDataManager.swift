//
//  File.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

class DetailDataManager {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getCharacter(
        id: Int,
        success: @escaping (CharacterDetailModel) -> Void,
        failure: @escaping (String) -> Void
    ) {
        apiClient.characterDetailRequest(id: id) { characterDetailDTO in
            print(characterDetailDTO)
            success(characterDetailDTO.toCharacterDetailModel())
        } failure: { error in
            failure(error)
        }
    }
}
