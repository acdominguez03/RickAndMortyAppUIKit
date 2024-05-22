//
//  DetailViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var character: CharacterDetailModel?
    let apiClient = ApiClient()
    
    func getCharacter(id: Int) {
        apiClient.characterDetailRequest(id: id) { [weak self] characterDTO in
            print(characterDTO)
            self?.character = characterDTO.toCharacterDetailModel()
        } failure: { error in
            print(error)
        }
    }
}
