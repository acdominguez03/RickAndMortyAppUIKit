//
//  DetailViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var character: CharacterDetailModel?
    
    let dataManager: DetailDataManager
    let characterId: Int
    
    init( dataManager: DetailDataManager, characterId: Int) {
        self.dataManager = dataManager
        self.characterId = characterId
    }
    
    func getCharacter(id: Int) {
        dataManager.getCharacter(id: characterId, success: { character in
            self.character = character
        }, failure: { error in
            print(error)
        })
    }
}
